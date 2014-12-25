require 'spec_helper'

feature "Interact with queue" do
  scenario "adds and reorders videos" do
    comedies = Fabricate(:category)
    video1 = Fabricate(:video, title: "Monk", category: comedies)
    video2 = Fabricate(:video, title: "South Park", category: comedies)
    video3 = Fabricate(:video, title: "Futurama", category: comedies)
    
    sign_in
    
    add_video_to_queue(video1)
    page.should have_content(video1.title)
    
    visit video_path(video1)
    page.should_not have_content "+ My Queue"
        
    add_video_to_queue(video2)
    add_video_to_queue(video3)
  
    set_video_position(video1, 3)
    set_video_position(video2, 1)
    set_video_position(video3, 2)
    
    click_button "Update Instant Queue"
    
    expect_video_position(video1, 3)
    expect_video_position(video2, 1)
    expect_video_position(video3, 2)
  end
  
  def add_video_to_queue(video)
    visit home_path
    click_on_video(video)
    click_link "+ My Queue"   
  end
  
  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end
  
  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input [@type='text']").value).to eq(position.to_s)
  end
  
end