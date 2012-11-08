class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_signin_path, :notice => "Signed up successfully. Please Sign in to continue."
    else
      flash.now[:alert] = @user.errors.full_messages.join('; ')
      render 'new'
    end
  end
end
