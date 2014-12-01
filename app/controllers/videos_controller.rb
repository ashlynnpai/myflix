class VideosController < ApplicationController
  before_action :set_video, only: [:show]
  
  def index
    @videos = Video.all
    @categories = Category.all
  end
  
  def show
  end
  
  private
  
   def post_params
     params.require(:video).permit(:title, :description, :small, :large)
  end
  
  def set_video
    @video = Video.find(params[:id])
  end
  
end