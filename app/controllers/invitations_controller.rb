class InvitationsController < ApplicationController
  before_filter :require_user
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.create(invitation_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.delay.send_invitation_email(@invitation)
      flash[:success] = "Your invitation was sent to #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:error] = "Please check your input."
      render :new
    end
  end
  
  private
  
   def invitation_params
     params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
   end
end