class PasswordResetsController < ApplicationController
  
  def show
    user = User.where(token: params[:id]).first
    if user
      @token = user.token
    else
      redirect_to expired_token_path 
    end
  end
  
  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.save
      if user.update_attribute(:password, user.password)
        flash[:success] = "Your password has been changed. Please sign in."
        user.token = nil
        user.save
        redirect_to login_path
      else
        redirect_to password_reset_url(user.token)
      end
    else
      redirect_to expired_token_path
    end
  end
  
  private

  

end