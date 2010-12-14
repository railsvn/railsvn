class ActionUnauthorized < Exception; end

class ApplicationController < ActionController::Base
  include FriendlyUrlHelper

  protect_from_forgery
  layout 'application'

  before_filter :record_page_view

protected
  def require_admin!
    unauthorized! unless user_signed_in? && current_user.admin?
  end

  def unauthorized!(message = "You don't have permission to access this page")
    raise ActionUnauthorized, message
  end

  def record_page_view
    if request.get? && !request.xhr?
      PageView.create!(:request_uri => request.fullpath,
                       :ip => request.remote_ip,
                       :user_agent => request.user_agent,
                       :referrer => request.referrer,
                       :signed_in_user_id => (user_signed_in? ? current_user.id : nil))
    end
  end

  rescue_from ActionUnauthorized do |e|
    redirect_to root_url, :alert => e.message
  end
end
