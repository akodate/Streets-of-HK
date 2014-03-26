class UserNotifier < ActionMailer::Base

  LINK_TO_RESET = "[Streets of HK] Reset your credentials"
  WAS_RESET     = "[Streets of HK] Your password has been reset!"

  default from: "Streets of HK <webmaster@streetsofhk.com>"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: LINK_TO_RESET
  end


  def password_was_reset(user)
    @user = user
    mail to: @user.email, subject: WAS_RESET
  end


end
