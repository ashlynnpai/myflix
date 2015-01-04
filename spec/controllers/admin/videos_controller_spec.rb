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
    
    context "without admin role" do
      it "redirects to home" do
        set_current_user
        get :new
        expect(response).to redirect_to home_path
      end
    end
  end
  
  describe 'POST create' do
    
  end
end