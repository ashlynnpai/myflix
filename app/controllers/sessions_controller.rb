class SessionsController<ApplicationController
  def new
    redirect_to home_path if current_user
  end
  
  def create
    user = User.where(email: params[:email]).first    
    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        flash[:success] = "You are now logged in."
        redirect_to home_path
      else
        flash[:danger] = "Your account has been suspended."
        redirect_to login_path
      end
    else
      flash[:danger] = "There's something wrong with your username or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now logged out."
    redirect_to root_path
  end
end