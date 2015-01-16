require 'spec_helper'

feature "Signing in" do

  scenario "Signing in with correct credentials" do
    user1 = Fabricate(:user)
    sign_in(user1)
    expect(page).to have_content user1.name
  end

  scenario "Signing in with wrong credentials" do
    user1 = Fabricate(:user)
    visit login_path
    fill_in 'Email', :with => user1.email
    fill_in 'Password', :with => "wrongway"
    click_button 'Sign in'
    expect(page).to have_content "There's something wrong with your username or password."
  end
  
  scenario "with deactivated user" do
    user1 = Fabricate(:user, active: false)
    sign_in(user1)
    expect(page).not_to have_content(user1.name)
    expect(page).to have_content("Your account has been suspended.")
  end
  
end