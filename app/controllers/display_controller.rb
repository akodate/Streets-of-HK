class DisplayController < ApplicationController

  def new



    render :layout => false
    session[:result] = []
  end

end