class SessionsController<ApplicationController
  def new
    redirect_to home_path if current_user
  end
  
  def create
    user = User.where(email: params[:email]).first
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      AppMailer.welcome_mail(@user).deliver
      redirect_to home_path
    else
      flash[:error] = "There's something wrong with your username or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to root_path
  end
end