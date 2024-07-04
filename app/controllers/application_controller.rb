class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_admin
    @current_admin ||= User.find_by(id: session[:user_id])
  end

  def require_user_logged_in
    redirect_to new_session_path, flash: { notice: 'Kindly login' } if @current_user.nil?
  end
end
