class SiteController < ApplicationController

  # before_action :is_authenticated?

  def index
  end

  def search
    if params[:term]
      # Searches using URI of clicked search suggestion
      result = StreetData.look_up(params[:term])
    else
      # Searches using search field input
      result = StreetData.look_up(params[:search][:term])
    end
    search_result(result)
  end

  def search_result(result)
    # Display street card if only one match comes back
    if result.size == 1
      session[:result] = result
      redirect_to display_url
    # Display error if no matches come back
    elsif result.size == 0
      redirect_to error_url
    # Display search suggestions if multiple matches come back
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