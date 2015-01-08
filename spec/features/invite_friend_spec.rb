require 'capybara/email/rspec'
require 'spec_helper'

feature 'Invite a Friend' do
  scenario 'invite a friend', { js: true, vcr: true } do
    user = Fabricate(:user)
    sign_in(user)
    
    send_invitation
    
    friend_accepts_invitation

    fill_in "Email Address", with: "friend@email.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
    
    click_link "People"
    expect(page).to have_content user.name
    sign_out
    
    sign_in(user)
    click_link "People"
    expect(page).to have_content "Happy Hippo"
    
    clear_email
  end
  
  def send_invitation
    visit new_invitation_path    
    fill_in "Friend's Name", :with => 'Happy Hippo'
    fill_in "Friend's Email Address", :with => 'friend@email.com'
    fill_in "Message", :with => 'Join this site.'
    click_button "Send Invitation"
    sign_out
  end
  
  def friend_accepts_invitation
    open_email('friend@email.com')
    current_email.click_link 'Accept Invitation'
    fill_in "Password", :with => 'password1'
    fill_in "Full Name", :with => 'Happy Hippo'
    fill_in "Credit Card Number", :with => "4242424242424242"
    fill_in "Security Code", :with => "123"
    select "7 - July", from: "date_month"
    select "2017", from: "date_year"
    click_button "Sign Up"
  end
end



    