require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue of logged in user" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      queue_item1 = Fabricate(:queue_item, user: user1)
      queue_item2 = Fabricate(:queue_item, user: user1)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to login for unauthenticated users" do
      get :index
      expect(response).to redirect_to login_path
    end
  end
  
  describe "POST create" do
    it "redirects to my queue" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates the queue item associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)      
    end
    it "creates the queue item associated with the logged in user" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user1)  
    end
    it "puts the video at the end of the queue" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: user1)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: user1.id).first
      expect(south_park_queue_item.position).to eq(2)
    end

    it "does not add video if it is already in the queue" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: user1)
      post :create, video_id: monk.id
      expect(user1.queue_items.count).to eq(1)
    end
    it "redirects to sign in for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to login_path
    end
  end
  
  describe "DELETE destroy" do
    it "redirects to my queue" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      get :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
  end
      it "deletes a queue item" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      queue_item = Fabricate(:queue_item, user: user1)
      get :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete if not current user's queue" do
      user1 = Fabricate(:user)
      unauthorized_user = Fabricate(:user)
      session[:user_id] = unauthorized_user.id
      queue_item = Fabricate(:queue_item, user: user1)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)     
    end
  it "redirects to login page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to login_path
  end
  
end