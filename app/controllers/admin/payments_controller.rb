class Admin::PaymentsController < AdminsController 
  before_filter :require_user
  before_filter :ensure_admin  #defined in admins_controller.rb
  
  def index
    @payments = Payment.all
  end
end