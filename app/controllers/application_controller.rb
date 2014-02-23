class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= Person.find(session[:current_user_id]) if session[:current_user_id]
  end
end
