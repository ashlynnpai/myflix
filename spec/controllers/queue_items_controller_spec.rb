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
end