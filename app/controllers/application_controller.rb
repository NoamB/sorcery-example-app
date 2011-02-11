class ApplicationController < ActionController::Base
  protect_from_forgery
  
  activate_sorcery! do |config|
    config.session_timeout = 10.minutes
    config.session_timeout_from_last_action = false
    config.login_retries_amount_allowed = 20
    config.login_retries_time_period = 20
    config.login_ban_time_period = 2.minutes
    config.controller_to_realm_map = {"application" => "Application", "users" => "Users"}
  end
  
  before_filter :require_user_login, :except => [:not_authenticated]
  
  helper_method :logged_in_users_list
  
  protected
  
  def not_authenticated
    redirect_to root_path, :alert => "Please login first."
  end
  
  def logged_in_users_list
    logged_in_users.map {|u| u.email}.join(", ")
  end
end
