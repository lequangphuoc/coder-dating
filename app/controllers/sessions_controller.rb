class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'You logged in successfully'
      redirect_to users_path
    else
      flash[:error] = 'Something wrong with your login information'
      render 'new'
    end
  end
end
