require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      assigns(:user).should be_new_record
    end
  end
  
  describe "POST create" do
    context "successful user sign up" do      
      it "redirects to signin" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to login_path
      end 
    end
    
    context "failed user sign up" do
      it "sets @user" do
        result = double(:sign_up_result, successful?: false, error_message: "Error message")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '1234'
        expect(assigns(:user)).to be_instance_of(User)
      end
      it "renders the new template" do
        result = double(:sign_up_result, successful?: false, error_message: "Error message")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '1234'
        expect(response).to render_template :new
      end
      it "sets the flash error message" do
        result = double(:sign_up_result, successful?: false, error_message: "Error message")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '1234'
        expect(flash[:error]).to be_present
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
  
  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end
    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: '123'
      expect(response).to redirect_to expired_token_path
    end
  end
  
end
