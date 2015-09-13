class WelcomeMailer < ActionMailer::Base
    default from: "team@mizikjams.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.welcome.subject
  #
  def welcome(user)
   	 @user = user
      mail(to: @user.email, subject: "Welcome to mizikjams")
   end
end
