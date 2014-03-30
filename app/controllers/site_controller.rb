class SiteController < ApplicationController

  # before_action :is_authenticated?

  def index
    # render json: User.all.entries
    # @users = User.all.entries
  end

  def search
    if params[:term]
      result = StreetData.look_up(params[:term])
    else
      result = StreetData.look_up(params[:search][:term])
    end

    if result.size == 1
      session[:result] = result
      redirect_to display_url
    else
      session[:result] = result.map{ |i| i.keys[0] }
      render :index
    end
  end

  def privacy
    render :privacy
  end

  def terms
    render :terms
  end

end