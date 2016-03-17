class SessionsController < ApplicationController
  before_filter :skip_if_logged_in, only: [:new]
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'You logged in successfully'
      redirect_to users_path
    else
      flash.now[:error] = 'Something wrong with your login information'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_path
  end
end
