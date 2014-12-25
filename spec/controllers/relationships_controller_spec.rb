require 'spec_helper'

describe RelationshipsController do
  
  describe "GET index" do
    it "sets @relationships to the current user's following relationships" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)
      session[:user_id] = follower.id      
      relationship = Fabricate(:relationship, follower: follower, leader: leader)
      get :index
      expect(assigns(:relationships)).to eq ([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end
  
  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end
    
    it "redirects to the people page" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)
      session[:user_id] = follower.id     
      relationship = Fabricate(:relationship, follower: follower, leader: leader)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path  
    end
    
    it "deletes the relationship if the current user is the follower" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)
      session[:user_id] = follower.id     
      relationship = Fabricate(:relationship, follower: follower, leader: leader)
      delete :destroy, id: relationship
      expect(assigns(:relationships)).not_to eq ([relationship])      
    end
        
    it "does not delete the relationship if the current user is not the follower" do
      leader = Fabricate(:user)
      follower = Fabricate(:user)
      lurker = Fabricate(:user)
      session[:user_id] = follower.id     
      relationship = Fabricate(:relationship, follower: lurker, leader: leader)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end
    
    describe "POST create" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, leader_id: 3 }
      end
      
      it "make the current user follow the leader" do
        leader = Fabricate(:user)
        follower = Fabricate(:user)
        session[:user_id] = follower.id      
        post :create, leader_id: leader.id
        expect(follower.following_relationships.first.leader).to eq(leader)
      end
      
      it "redirects to the people page" do
        leader = Fabricate(:user)
        follower = Fabricate(:user)
        session[:user_id] = follower.id      
        post :create, leader_id: leader.id
        expect(response).to redirect_to people_path
      end
      it "does not follow the same user twice" do
        leader = Fabricate(:user)
        follower = Fabricate(:user)
        session[:user_id] = follower.id      
        relationship = Fabricate(:relationship, follower: follower, leader: leader)
        post :create, leader_id: leader.id
        expect(Relationship.count).to eq(1)
      end
      
      it "cannot follow oneself" do
        follower = Fabricate(:user)
        session[:user_id] = follower.id      
        post :create, leader_id: follower.id
        expect(Relationship.count).to eq(0)
      end
    end

end