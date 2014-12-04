class VideosController < ApplicationController
  before_action :set_video, only: [:show]
  before_filter :require_user
  
  def index
    @categories = Category.all
  end
  
  def show
  end
  
  def search
    @results = Video.search_by_title(params[:search_term]) 
  end
  
  private
  
   def post_params
     params.require(:video).permit(:title, :description, :small, :large)
  end
  
  def set_video
    @video = Video.find(params[:id])
  end
    
end