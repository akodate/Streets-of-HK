class RegisterController < ApplicationController

  NO_FORM = "Please fill out all fields"
  NO_MATCH = "Passwords do not match"
  USER_EXISTS = "That e-mail is already taken. Please choose another one"
  REGISTERED = "You're now registered and logged in!"

  def new

  end

  def create
    if params[:user][:email].blank? || params[:user][:password].blank?
      flash.now[:alert] = NO_FORM
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:alert] = NO_MATCH
    elsif User.find_by(email: params[:user][:email])
      flash.now[:alert] = USER_EXISTS
    else
      RegistrationHandler.new(flash).new_user(params)
      # return if log_user_in( UserAuthenticator.new(session,flash).authenticate_user(user_params) )
    end
    # (redirect_to root_url and return) if flash.empty?
  end

  def confirm
    @user = User.confirm_user(params)
    if log_user_in( @user, REGISTERED )
      return
      # redirect_to( root_url, notice: REGISTERED ) and return
    else
      flash.now[:alert] = @user.errors
    end
  end

end