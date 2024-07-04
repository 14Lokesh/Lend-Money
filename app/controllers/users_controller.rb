class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[dashboard]
  def index
  end

  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to new_session_path
    else  
      render :new
    end
  end

  def dashboard
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
