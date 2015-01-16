require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items) }
  it { should have_many(:reviews) }
  
  
#   it "generates a random token when password request is made" do
#     user = Fabricate(:user)
#     expect(user.token).to be_present
#   end
  
  describe "#queued_video?" do
    it "returns true when the user queues the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_truthy
    end
    
    it "returns false when the user has not queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      user.queued_video?(video).should be_falsey
    end
  end
  
  describe "#follows?" do
    it "returns true if relationship exists" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)    
      Fabricate(:relationship, follower: follower, leader: leader)
      expect(follower.follows?(leader)).to be_truthy
    end
    it "returns false if no relationship" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)    
      lurker = Fabricate(:user)
      Fabricate(:relationship, follower: follower, leader: lurker)
      expect(follower.follows?(leader)).to be_falsey
    end
  end
  
  describe "#follow" do
    it "follows another user" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)    
      follower.follow(leader)
      expect(follower.follows?(leader)).to be_truthy
    end
    it "does not follow oneself" do
      leader = Fabricate(:user)
      leader.follow(leader)
      expect(leader.follows?(leader)).to be_falsey
    end
  end
  
  describe "deactivate!" do
    it "deactivates the user" do
    user = Fabricate(:user, active: true)
    user.deactivate!
    expect(user).not_to be_active
    end
  end
end