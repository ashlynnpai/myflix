require 'spec_helper'

feature "Admin sees payments" do
  background do
    user = Fabricate(:user, name: "Happy Hippo", email: "user1@example.com")
    Fabricate(:payment, amount: 999, user: user)
  end
  
  scenario "admin can see payments" do
    sign_in(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Happy Hippo")
    expect(page).to have_content("user1@example.com")
  end
  
  scenario "user cannot see payments" do
    sign_in(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Happy Hippo")
    expect(page).to have_content("You do not have access to that area")
  end

end