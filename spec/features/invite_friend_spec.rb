require 'capybara/email/rspec'
require 'spec_helper'

feature 'Invite a Friend' do
  scenario 'invite a friend', { js: true, vcr: true } do
    user = Fabricate(:user)
    sign_in(user)
    
    send_invitation
    
    friend_accepts_invitation
    
    expect(page).to have_content 'Sign in '
    expect(page).to have_content 'Email'

    fill_in 'Email', :with => 'friend@example.com'
    fill_in 'Password', :with => 'password1'
    click_button "Sign in"
    expect(page).to have_content 'Friendly Fran'
    
    click_link "People"
    expect(page).to have_content user.name
    sign_out
    
    sign_in(user)
    click_link "People"
    expect(page).to have_content "Friendly Fran"
    
    clear_email
  end
  
  def send_invitation
    visit new_invitation_path    
    fill_in "Friend's Name", :with => 'Friendly Fran'
    fill_in "Friend's Email Address", :with => 'friend@example.com'
    fill_in "Message", :with => 'Join this site.'
    click_button "Send Invitation"
    sign_out
  end
  
  def friend_accepts_invitation
    open_email('friend@example.com')
    current_email.click_link 'Accept Invitation'
    fill_in "Email", :with => 'friend@example.com'
    fill_in "Password", :with => 'password1'
    fill_in "Confirm Password", :with => 'password1'
    fill_in "Full Name", :with => 'Friendly Fran'
    fill_in "Credit Card Number", :with => "4242424242424242"
    fill_in "Security Code", :with => "123"
    select "7 - July", from: "date_month"
    select "2017", from: "date_year"
    click_button "Sign Up"
  end
end



    