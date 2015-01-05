require 'spec_helper'

describe Admin::VideosController do  
  describe 'GET new' do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    it "sets @video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record   
    end  
    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end
  end
  
  describe 'POST create' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end
    
    context "with valid input" do
      it "creates a video" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { title: "Monk", category_id: category.id, description: "About Monk" }
        expect(category.videos.count).to eq(1)
      end
      it "redirects to the add video page" do    
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { title: "Monk", category_id: category.id, description: "About Monk" }
        expect(response).to redirect_to new_admin_video_path
      end
      it "sets flash success" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { title: "Monk", category_id: category.id, description: "About Monk" }
        expect(flash[:success]).to be_present
      end
    end
    
    context "with invalid input" do
      it "doest not create a video" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { category_id: category.id, description: "About Monk" }
        expect(category.videos.count).to eq(0)
      end
      it "renders the :new template" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { category_id: category.id, description: "About Monk" }
        expect(response).to render_template :new
      end
      it "sets the @video variable" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { category_id: category.id, description: "About Monk" }
        expect(assigns(:video)).to be_present
      end
      it "sets flash error" do
        category = Fabricate(:category)
        set_current_admin
        post :create, video: { category_id: category.id, description: "About Monk" }
        expect(flash[:error]).to be_present
      end
    end
  end
  
end