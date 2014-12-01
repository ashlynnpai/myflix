class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  
  def show
    
  end
  
  private
  
   def post_params
     params.require(:video).permit(:title, :description, :small, :large)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
end