class DisplayController < ApplicationController

  def new
    render :layout => false
    session[:result] = []
  end

  def error
    render :layout => false
  end

end