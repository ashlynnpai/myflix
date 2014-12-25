require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  
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
end