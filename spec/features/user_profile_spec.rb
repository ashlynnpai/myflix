require 'spec_helper'

feature "User profile" do
  scenario "shows the user profile" do
    comedy = Fabricate(:category, name: "Comedy")
    video = Fabricate(:video, title: "News", category: comedy)
    user = Fabricate(:user, name: "Happy Hippo")
    review = Fabricate(:review, user: user, video: video)
    
    sign_in
    
    visit home_path
    click_on_video(video)

    page.should have_content("News")
    click_link("Happy Hippo")
    page.should have_content("Happy Hippo")
  end
end