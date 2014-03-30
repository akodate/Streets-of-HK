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
    puts result.map{ |i| i.keys }
    session[:result] = result.map{ |i| i.keys[0] }
    redirect_to root_url
  end

  def privacy
  end

  def terms
  end

end