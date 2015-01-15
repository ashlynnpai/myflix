require 'spec_helper'

feature "Add a video" do
  scenario "admin adds a video" do
    admin = Fabricate(:admin)
    comedy = Fabricate(:category, name: "Comedy")
    
    visit login_path
    fill_in "Email Address", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign in"
    
    visit new_admin_video_path
    page.should have_content('Add a New Video')
    
    fill_in "Title", with: "Ferris Bueller"
    select "Comedy", from: "Category"
    fill_in "Description", with: "a movie"
    attach_file "Large", "spec/support/uploads/futurama.jpg"
    attach_file "Small", "spec/support/uploads/futurama.jpg"
    fill_in "Video URL", with: "http://youtu.be/uhiCFdWeQfA"
    click_button "Add Video"
    page.should have_content('You have added')
    
    sign_out
    
    user = Fabricate(:user, admin: false)
    sign_in(user)
    visit video_path(Video.first)
    page.should have_content('Ferris Bueller')
    #expect(page).to have_selector("img[src='/uploads/futurama.jpg']")
    expect(page).to have_selector("a[href='http://youtu.be/uhiCFdWeQfA']")
    visit new_admin_video_path
    expect(page).to have_content("You do not have access to that area")
  end
end

