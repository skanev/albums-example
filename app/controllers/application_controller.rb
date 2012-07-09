class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def require_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: 'You must be logged in to perform this action'
    end
  end
end
