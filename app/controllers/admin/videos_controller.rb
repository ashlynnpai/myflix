class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin
  
  def new
    @video = Video.new
  end
  
  def require_admin
    if !current_user.admin?
      redirect_to home_path
    end
  end
end