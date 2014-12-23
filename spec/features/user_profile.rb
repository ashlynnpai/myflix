require 'spec_helper'

feature "User profile" do
  scenario "shows the user profile" do
    video = Fabricate(:video)
    user = Fabricate(:user)
    review = Fabricate(:review, user: user, video: video)
        
    video_path(video)
    
    click_link(review.user.name)
    page.should have_content(user.name)
  end
end