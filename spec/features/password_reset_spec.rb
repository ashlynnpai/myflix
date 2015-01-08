require 'capybara/email/rspec'
require 'spec_helper'

feature 'Password Reset' do
  scenario 'request password reset' do
    user = Fabricate(:user, email: 'test@example.com', password: 'oldpass')
    visit login_path
    click_link "Forgot Password?"
    page.should have_content('We will send you an email with a link that you can use to reset your password')
    
    fill_in 'Email Address', :with => 'test@example.com'
    click_button "Send Email"
    page.should have_content('We have sent an email with instructions to reset your password.')
    
    open_email('test@example.com')
    current_email.click_link 'Reset Password'
    page.should have_content('Reset Your Password')
    
    fill_in 'New Password', :with => 'newpass'
    click_button 'Reset Password'
    page.should have_content('Your password has been changed')

    fill_in 'Email Address', :with => 'test@example.com'
    fill_in 'Password', :with => 'newpass'
    click_button 'Sign in'
    page.should have_content("Welcome, #{user.name}")

    clear_email
  end
end