class ForgotPasswordsController < ApplicationController
  
  def create
    user = User.where(email: params[:email]).first
    if user
      user.generate_token
      user.save
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = "Please enter a valid email address."
      redirect_to forgot_password_path
    end
  end

  
end