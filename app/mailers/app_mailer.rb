class AppMailer < ActionMailer::Base
  default "awebcafe@gmeail.com"
  layout 'mailer'
  
  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MyFlix')
  end
end