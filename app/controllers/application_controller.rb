class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :route_not_found

  private

  def record_not_found
    render plain: "Page not found"
  end
end
