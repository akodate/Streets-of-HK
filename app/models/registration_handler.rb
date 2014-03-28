class RegistrationHandler

  SUCCESS = "Success! Please check your e-mail to confirm"
  NO_MAIL = "Unable to send email. Please try again later"
  NO_SAVE = "Registration failed. Please try again later"

  def initialize(flash)
    @flash = flash
  end

  def new_user(params)
    @user = User.new(
      email: params[:user][:email],
      password: params[:user][:password]
    )
    if @user.set_password_reset
      puts "#{@user}" + "THIS IS THE USER IT'S VALID"
      send_register_email
    else
      @flash.now[:alert] = NO_SAVE
    end
  end

  def send_register_email
    puts "#{@user}" + "IS THE USER STILL HERE?"
    begin
      RegisterNotifier.register(@user).deliver
      @flash.now[:notice] = SUCCESS
    rescue
      @flash.now[:alert] = NO_MAIL
    end
  end

end