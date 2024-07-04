class SessionsController < ApplicationController
  def new
  end

  def create
    # binding.pry
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      # binding.pry
      redirect_to dashboard_user_path(@user)
    else  
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end


  private

def user_params
  params.require(:user).permit(:email, :password)
end
end