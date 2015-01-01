class AppMailer < ActionMailer::Base
  default from: "flixmaster@myflix.com"

  def welcome_mail(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to MyFlix')
  end
  
  def send_forgot_password(user)
    @user = user
    mail(to: user.email, subject: 'Reset Password to MyFlix')
  end
  
  def send_invitation_email(invitation)
    @invitation = invitation
    mail(to: invitation.recipient_email, subject: 'Invitation to join MyFlix')
  end
end