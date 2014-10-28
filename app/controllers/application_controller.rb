class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
    current_user.try(:admin?)
  end
  helper_method :admin?

  def authorize
    unless admin?
      flash[:error] = "unauthorized access"
      redirect_to home_path
      false
    end
  end

end
