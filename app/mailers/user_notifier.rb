class UserNotifier < ActionMailer::Base

  default from: "Streets of HK <webmaster@streetsofHK.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: "[Streets of HK] Reset your credentials"
  end

  def password_was_reset(user)
  end

end