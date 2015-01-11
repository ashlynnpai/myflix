class UserSignup
  
  attr_reader :error_message
  
  def initialize(user)
    @user = user
  end
  
  def sign_up(stripe_token, invitation_token)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => stripe_token,
        :description => "Charge for MyFlix for #{@user.email}")
      if charge.successful?
        @user.save
        handle_invitation(invitation_token)
        AppMailer.welcome_mail(@user).deliver
        @status = :success
        self
      else
        @status = :failed
        @error_message = charge.error_message
      end
    else
      @status = :failed
      self
    end
  end
  
  def successful?
    @status == :success
  end
  
  private
  
  def handle_invitation(invitation_token)
    if invitation_token.present?      
      invitation = Invitation.where(token: invitation_token).first    
      @user.follow(invitation.inviter)      
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
end