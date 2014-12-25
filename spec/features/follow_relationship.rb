require 'spec_helper'

feature "Follow/unfollow relationship" do
  scenario "adds and reorders videos" do
    comedies = Fabricate(:category)
    leader = Fabricate(:user)
    video = Fabricate(:video, title: "Monk", category: comedies, small: "photo.jpg")
    follower = Fabricate(:user)
    review = Fabricate(:review, user: leader, video: video)
    
    sign_in
    click_on_video(video)
    
    click_link(leader.name)

    click_button "Follow"
    expect(page).to have_content(leader.name)

    unfollow(leader)
    expect(page).not_to have_content(leader.name)
    
 
  end
  
  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
    

 


