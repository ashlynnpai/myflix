class Admin::VideosController < AdminsController
  before_filter :require_user
  before_filter :ensure_admin  #defined in admins_controller.rb
  
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
  
  private
  
  def video_params
    params.require(:video).permit(:title, :description, :category_id, :small, :large, :video_url)
  end
end