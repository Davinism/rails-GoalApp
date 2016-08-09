class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username and/or password!"]
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    logout
    render :new
  end
end
