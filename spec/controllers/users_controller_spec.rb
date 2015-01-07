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
      before { post :create, stripeToken: get_stripe_token_id, user: Fabricate.attributes_for(:user, email: "test@email.com") }
      after { ActionMailer::Base.deliveries.clear }
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
      
    context "where the user was invited" do
      it "makes the user follow the inviter" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        post :create, user: {email: 'friend@email.com', password: 'password', name: 'My Friend'}, stripeToken: get_stripe_token_id, invitation_token: invitation.token
        friend = User.where(email: 'friend@email.com').first
        expect(friend.follows?(user)).to be_truthy
      end         
      it "makes the inviter follow the user" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        post :create, user: {email: 'friend@email.com', password: 'password', name: 'My Friend'}, stripeToken: get_stripe_token_id, invitation_token: invitation.token
        friend = User.where(email: 'friend@email.com').first
        expect(user.follows?(friend)).to be_truthy
      end
      it "expires the invitation upon acceptance" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        post :create, user: {email: 'friend@email.com', password: 'password', name: 'My Friend'}, stripeToken: get_stripe_token_id, invitation_token: invitation.token
        friend = User.where(email: 'friend@email.com').first
        expect(Invitation.first.token).to be_nil
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
