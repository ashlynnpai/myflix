require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue of logged in user" do
      set_current_user
      queue_item1 = Fabricate(:queue_item, user: current_user)
      queue_item2 = Fabricate(:queue_item, user: current_user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end
  end
  
  describe "POST create" do
    it "redirects to my queue" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a queue item" do
      set_current_user
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
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end
  
  describe "DELETE destroy" do
    it "redirects to my queue" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    
    it "deletes a queue item" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      queue_item = Fabricate(:queue_item, user: user1)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
  
    it "normalizes the remaining queue items" do
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      queue_item1 = Fabricate(:queue_item, user: user1, position: 1)
      queue_item2 = Fabricate(:queue_item, user: user1, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end
  
    it "does not delete if not current user's queue" do
      user1 = Fabricate(:user)
      unauthorized_user = Fabricate(:user)
      session[:user_id] = unauthorized_user.id
      queue_item = Fabricate(:queue_item, user: user1)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)     
    end

     it_behaves_like "requires sign in" do
       let(:action) { delete :destroy, id: 3 }
     end
  end
  
  describe "POST update_queue" do
    
    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 2, position: 1}, {id: 3, position: 2}] }
    end
    
    context "with valid inputs" do
      
      let(:user1) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: user1, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: user1, position: 2, video: video) }
      
      before do
        session[:user_id] = user1.id
      end
        it "redirects to the my queue page" do      
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        
        it "normalizes the position numbers" do      
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
          expect(user1.queue_items).to eq([queue_item2, queue_item1])
        end
    end
    
    it "reorders the queue items" do 
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user1, position: 1, video: video) 
      queue_item2 = Fabricate(:queue_item, user: user1, position: 2, video: video) 
      post :update_queue, queue_items: [{id: queue_item2.id, position: 1}]
      expect(user1.queue_items).to eq([queue_item2, queue_item1])
    end
    
    it "reorders the queue items with four items in the queue" do 
      user1 = Fabricate(:user)
      session[:user_id] = user1.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user1, position: 1, video: video) 
      queue_item2 = Fabricate(:queue_item, user: user1, position: 2, video: video) 
      queue_item3 = Fabricate(:queue_item, user: user1, position: 3, video: video) 
      queue_item4 = Fabricate(:queue_item, user: user1, position: 4, video: video) 
      post :update_queue, queue_items: [{id: queue_item4.id, position: 1}]
      expect(user1.queue_items).to eq([queue_item4, queue_item1, queue_item2, queue_item3])
    end
    
    
    context "with invalid inputs" do
      
      let(:user1) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: user1, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: user1, position: 2, video: video) }
      
      before do
        session[:user_id] = user1.id
      end
      
      it "redirects to the my_queue page" do 
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do 
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(flash[:error]).to be_present
      end
      it "does not change the queue items"do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(3)
      end
    end
        
    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        user1 = Fabricate(:user)
        user2 = Fabricate(:user)
        session[:user_id] = user2.id
        queue_item1 = Fabricate(:queue_item, user: user1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user1, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
  
end