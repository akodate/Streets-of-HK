class SessionController < ApplicationController

  # skip_before_action :verify_authenticity_token

  def new
    redirect_to root_url, notice: "You are logged in." if current_user
  end

  def create
    if params[:user][:password].blank?
      #password reset flow
      PasswordResetter.new(flash).handle_reset_request(user_params)
    else
      #authenticate password flow
      return if log_user_in( UserAuthenticator.new(session,flash).authenticate_user(user_params) )
    end
    # (redirect_to root_url and return) if flash.empty?
    render :new
  end

  def destroy
    log_user_out
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
