require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    
    context "with no input" do      
      it "redirects to forgot password" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it "shows error message" do
        post :create, email: ''
        expect(flash[:error]).to be_present
      end            
    end
  
    context "with valid input" do
      it "sends an email" do
        Fabricate(:user, email: 'user1@email.com')
        post :create, email: 'user1@email.com'
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["user1@email.com"]
      end
      it "redirects to confirmation page" do 
        Fabricate(:user, email: 'user1@email.com')
        post :create, email: 'user1@email.com'
        expect(response).to redirect_to forgot_password_confirmation_path
      end        
      
      it "generates a random token when password request is made" do
        user = Fabricate(:user, email: 'user1@email.com')
        post :create, email: 'user1@email.com'
        expect(user.reload.token).to be_present
      end
    end
    
    context "with invalid input" do
      it "shows error message" do
        Fabricate(:user, email: 'user1@email.com')
        post :create, email: 'user2@email.com'
        expect(flash[:error]).to be_present
      end
      it "redirects to forgot password" do
        Fabricate(:user, email: 'user1@email.com')
        post :create, email: 'user2@email.com'
        expect(response).to redirect_to forgot_password_path
      end
    end
    
  end
end