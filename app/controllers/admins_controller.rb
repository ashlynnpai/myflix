class AdminsController < ApplicationController
  before_filter :require_user
  before_filter :ensure_admin

  def ensure_admin
    unless current_user.admin?
      flash[:danger] = "You do not have access to that area."
      redirect_to home_path
    end
  end
end