class RootController < ApplicationController
  def index
    if current_user
      redirect_to :user_dashboard
    else
      redirect_to user_signin_path
    end
  end
end
