class UsersController < ApplicationController
  before_filter :require_login, only: [:index]
  before_filter :skip_if_logged_in, only: [:new]
  def new
    @user = User.new
  end

  def index
    @users = User.all.shuffle
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Welcome to our dating app'
      redirect_to users_path
    else
      flash.now[:error] = 'Something wrong with your login information'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
