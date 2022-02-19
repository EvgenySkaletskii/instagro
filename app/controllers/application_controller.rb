class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_record

  def route_not_found
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || feed_path)
  end

  def invalid_record
    flash[:alert] = "Please stop typing parameters manually."
    redirect_to(request.referrer || feed_path)
  end
end
