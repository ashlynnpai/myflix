require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      assigns(:user).should be_new_record
    end
  end
  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user, email: "test@email.com") }
      
      it "creates user record" do
        expect(User.count).to eq(1)
      end
      it "redirects to signin" do
        expect(response).to redirect_to login_path
      end
      
      it "sends an email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end
      
      it "sends to the right recipient" do
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["test@email.com"]
      end
      
      it "has the right content" do
        message = ActionMailer::Base.deliveries.last
        message.body.should include('MyFlix has one of the largest selections of videos around.')
      end
      
    end
      
    context "with invalid input" do
      before { post :create, user: {password: "password"} }
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
  
   describe "GET show" do
    it "sets @user" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(response).to be_success
    end
  end
end
