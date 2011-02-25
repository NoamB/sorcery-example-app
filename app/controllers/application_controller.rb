require 'oauth'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  activate_sorcery! do |config|
    #config.user_class = User
    config.user_providers_class = UserProvider
    config.session_timeout = 10.minutes
    config.session_timeout_from_last_action = false
    
    config.controller_to_realm_map = {"application" => "Application", "users" => "Users"}
    
    config.oauth_providers = [:twitter]
    config.twitter.key = "eYVNBjBDi33aa9GkA3w"
    config.twitter.secret = "XpbeSdCoaKSmQGSeokz5qcUATClRW5u08QWNfv71N8"
    config.twitter.callback_url = "http://0.0.0.0:3000/login_with_twitter_callback"
  end
  
  before_filter :require_login, :except => [:not_authenticated, :login_with_twitter, :login_with_twitter_callback]
  
  helper_method :current_users_list
  
  # sends the user on a trip to twitter,
  # and after authorizing there back to the callback url.
  def login_with_twitter
    login_with_provider(:twitter)
  end
  
  def login_with_twitter_callback
    if @user = login_from_access_token(params[:oauth_token], params[:oauth_verifier])
      redirect_to root_path, :notice => "Logged in from Twitter!"
    else
      @access_token = get_access_token(:twitter)
      p @access_token
      redirect_to root_path, :alert => "Failed to login from Twitter!"
    end
  end
  
  protected
  
  def not_authenticated
    redirect_to root_path, :alert => "Please login first."
  end
  
  def current_users_list
    current_users.map {|u| u.email}.join(", ")
  end

end
