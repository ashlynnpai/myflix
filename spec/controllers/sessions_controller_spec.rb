require 'spec_helper' 

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new      
    end
    it "redirects to the home page for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end
  
  describe "POST create" do
    context "with valid credentials" do
      it "puts the signed in user in the session" do
        u = Fabricate(:user)
        post :create, email: u.email, password: u.password
        expect(session[:user_id]).to eq(u.id)
      end
      it "redirects to the home page" do
        u = Fabricate(:user)
        post :create, email: u.email, password: u.password
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do 
        u = Fabricate(:user)
        post :create, email: u.email, password: u.password
        expect(flash[:success]).not_to be_blank
      end
    end
    
    context "with invalid credentials" do
      before do
        u = Fabricate(:user)
        post :create, email: u.email, password: u.password + 'wrong'
      end
      it "does not put signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      it "redirects to sign in page" do
        expect(response).to redirect_to login_path
      end
      it "sets the error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
  
  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
    it "sets the notice" do
      expect(flash[:success]).not_to be_blank
    end    
  end
end