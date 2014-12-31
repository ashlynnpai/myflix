require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      user = Fabricate(:user)
      user.update_column(:token, '123')
      get :show, id: '123'
      expect(response).to render_template :show
    end
    
    it "sets @token" do
      user = Fabricate(:user)
      user.update_column(:token, '123')
      get :show, id: '123'
      expect(assigns(:token)).to eq('123')      
    end
    
    it "redirects to the expired token page if token is not valid" do
      get :show, id: '123'
      expect(response).to redirect_to expired_token_path
    end
  end
  
  describe "POST create" do
    context "with valid token" do
      it "updates the user's password" do
        user = Fabricate(:user, password: 'oldpass')
        user.update_column(:token, '123')
        post :create, token: '123', password: 'newpass'
        expect(user.reload.authenticate('newpass')).to be_truthy
      end     
      it "redirects to the sign in page" do
        user = Fabricate(:user, password: 'oldpass')
        user.update_column(:token, '123')
        post :create, token: '123', password: 'newpass'
        expect(response).to redirect_to login_path
      end
      it "sets the flash success message" do
        user = Fabricate(:user, password: 'oldpass')
        user.update_column(:token, '123')
        post :create, token: '123', password: 'newpass'
        expect(flash[:success]).to be_present
      end
      it "destroys the token" do
        user = Fabricate(:user, password: 'oldpass')
        user.update_column(:token, '123')
        post :create, token: '123', password: 'newpass'
        expect(user.reload.token).not_to be_present
      end
    end

    # if need to test password validations:    
#     context "with invalid input" do
#        it "does not save the new password" do
#           user = Fabricate(:user, password: 'oldpass')
#           user.update_column(:token, '123')
#           post :create, token: '123', password: 'new'
#           expect(user.reload.authenticate('new')).to be_falsey
#        end
#        it "does not give a flash success message of the password is not valid" do
#           user = Fabricate(:user, password: 'oldpass')
#           user.update_column(:token, '123')
#           post :create, token: '123', password: 'new'
#           expect(flash[:success]).not_to be_present    
#         end
#       it "redirects to the password reset form" do
#           user = Fabricate(:user, password: 'oldpass')
#           user.update_column(:token, '123')
#           post :create, token: '123', password: 'new'
#           expect(response).to redirect_to password_reset_url(user.token)
#       end
#     end
    
    context "with invalid token" do
      it "redirects to the expired token path" do
        post :create, token: '123', password: 'somepass'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end