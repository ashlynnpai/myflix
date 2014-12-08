require 'spec_helper' 

describe VideosController do
  describe "GET show" do  
    video = Fabricate(:video)
    it "sets @video variable for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
    end      
    
    it "sets @reviews for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        assigns(:reviews).should =~ [review1, review2]
    end
    
    it "redirects the unauthenticated user to sign in" do
        get :show, id: video.id
        expect(response).to redirect_to login_path
    end
    
    it "sets @review for authenticated users" do
        review1 = Fabricate(:review, video: video)
        session[:user_id] = Fabricate(:user).id
        get :show, id: video.id
        assigns(:review).should be_new_record
    end   
  end  
 
  describe "GET search" do
    it "sets @results for authenticated users" do
      scooby = Fabricate(:video, title: "Scooby Doo")
      session[:user_id] = Fabricate(:user).id
      get :search, search_term: 'oob'
      expect(assigns(:results)).to eq([scooby])
    end    
    it "redirects the unauthenticated user to sign in" do
      scooby = Fabricate(:video, title: "Scooby Doo")
      get :search, search_term: 'rama'
      expect(response).to redirect_to login_path
    end
  end
end

