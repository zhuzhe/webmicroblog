# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
#before_filter :require_login
  def current_user

    User.find(session[:user_id])

  end

  def require_login
    if session[:user_id].nil?
      flash[:notice]='please login fisrt'
      redirect_to new_session_path
    end
  end
  def require_admin
    unless current_user.group.group_name=='admin'
      flash[:notice]='you are not a admin'
      redirect_to new_session_path
    end
  end
end
