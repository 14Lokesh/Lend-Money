class ApplicationController < ActionController::Base
  before_action :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_method

  def not_found_method
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_admin
    redirect_to root_path, flash: { notice: 'You are not an admin' } unless @current_user&.admin?
  end

  def require_user_logged_in
    redirect_to new_session_path, flash: { notice: 'Kindly login' } if @current_user.nil?
  end
end
