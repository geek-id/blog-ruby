class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html.erb", layout: "application", status: 404
  end
end
