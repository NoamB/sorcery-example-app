class ApplicationController < ActionController::Base
  protect_from_forgery
  
  activate_sorcery! do |config|
    config.session_timeout = 10.minutes
    config.session_timeout_from_last_action = false
  end
  
  before_filter :require_user_login, :except => [:not_authenticated]
  
  protected
  
  def not_authenticated
    redirect_to root_path, :alert => "Please login first."
  end
    
end
