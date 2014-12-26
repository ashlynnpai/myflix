class AppMailer < ActionMailer::Base
  default from: "awebcafe@gmail.com"

  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MyFlix')
  end
end