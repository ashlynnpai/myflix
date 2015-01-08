require 'spec_helper' 

describe VideosController do
  describe "GET show" do  
    it "sets @video variable for authenticated users" do
        video = Fabricate(:video)
        set_current_user
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
    end      
    
    it "sets @reviews for authenticated users" do
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        set_current_user
        get :show, id: video.id
        assigns(:reviews).should =~ [review1, review2]
    end
    
    it "redirects the unauthenticated user to sign in" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to login_path
    end
    
    it "sets @review for authenticated users" do
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        set_current_user
        get :show, id: video.id
        assigns(:review).should be_new_record
    end   
  end  
 
  describe "GET search" do
    it "sets @results for authenticated users" do
      scooby = Fabricate(:video, title: "Scooby Doo")
      set_current_user
      get :search, search_term: 'oob'
      expect(assigns(:results)).to eq([scooby])
    end    
    it "redirects the unauthenticated user to sign in" do
      scooby = Fabricate(:video, title: "Scooby Doo")
      get :search, search_term: 'rama'
      expect(response).to redirect_to login_path
    end
  end
  
  describe 'GET queue' do
    it "puts the video into the queue array" do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      @queue = ""
    end
  end
end

