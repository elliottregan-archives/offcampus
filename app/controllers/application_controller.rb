class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :setup_tagline

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

  def setup_tagline
    @tagline = true
    if user_signed_in?
      @tagline = false
    end

  end
end
