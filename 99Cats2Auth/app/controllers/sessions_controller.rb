class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login!(user)
      redirect_to user_url(@user)
    else
      @user = User.new
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    log_out!
    redirect_to cats_url
  end


end
