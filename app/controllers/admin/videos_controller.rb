class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin
  
  def new
    @video = Video.new
  end
  
  def create
    @video = Video.create(video_params)
    if @video.save
      flash[:success] = "You have added '#{@video.title}'."
      redirect_to new_admin_video_path
    else
      flash[:error] = "The video was not added."
      render :new
    end
  end
  
  def require_admin
    if !current_user.admin?
      redirect_to home_path
    end
  end
  
  private
  
  def video_params
    params.require(:video).permit(:title, :description, :category_id, :small, :large, :video_url)
  end
end