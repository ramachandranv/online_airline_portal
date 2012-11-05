class ApplicationController < ActionController::Base
  protect_from_forgery

  #helper methods
  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  def authenticate_user!
    redirect_to root_path if current_user.nil?
  end
end
