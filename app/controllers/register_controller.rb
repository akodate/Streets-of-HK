class RegisterController < ApplicationController

  NO_FORM = "WE REQUIRE MORE FORM FIELDS"
  NO_MATCH = "Passwords do not match"
  USER_EXISTS = "That e-mail is already taken. Please choose another one"
  REGISTERED = "You're now registered and logged in!"
  LINK_EXPIRED = "Link expired. Please register again."

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
    end
    # (redirect_to root_url and return) if flash.empty?
    render :new
  end

  def confirm
    if @user = User.find_by_code(params[:code])
    else
      redirect_to register_url, notice: LINK_EXPIRED
    end
    if log_user_in( @user, REGISTERED )
      return
    end
  end

end
