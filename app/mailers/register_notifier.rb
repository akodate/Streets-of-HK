class RegisterNotifier < ActionMailer::Base

  LINK_TO_REGISTER = "[Streets of HK] Registration Confirmation"

  default from: "Streets of HK <webmaster@streetsofhk.com>"

  def register(user)
    @user = user
    mail to: @user.email, subject: LINK_TO_REGISTER
  end

end