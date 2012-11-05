class SessionsController < ApplicationController
  def new
  end

  def create
    user_authorized = User.authenticate(params[:email], params[:password])
    if user_authorized
      session[:user_id] = user_authorized.id
      redirect_to user_dashboard_path, :notice => "Signed in successfully"
    else
      render 'new', :notice => "Email/password is incorrect"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to user_signin_path, :notice => "Signed out successfully"
  end
end
