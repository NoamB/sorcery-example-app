Collaboration::Application.config.sorcery.submodules = [:user_activation, :http_basic_auth, :remember_me, :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external]

Collaboration::Application.config.sorcery.configure do |config|
  config.session_timeout = 10.minutes
  config.session_timeout_from_last_action = false
  
  config.controller_to_realm_map = {"application" => "Application", "users" => "Users"}
  
  config.external_providers = [:twitter, :facebook]
  
  config.twitter.key = "eYVNBjBDi33aa9GkA3w"
  config.twitter.secret = "XpbeSdCoaKSmQGSeokz5qcUATClRW5u08QWNfv71N8"
  config.twitter.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=twitter"
  config.twitter.user_info_mapping = {:email => "screen_name"}
  
  config.facebook.key = "34cebc81c08a521bc66e212f947d73ec"
  config.facebook.secret = "5b458d179f61d4f036ee66a497ffbcd0"
  config.facebook.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=facebook"
  config.facebook.user_info_mapping = {:email => "name"}
  
  config.user_config do |user|
    user.username_attribute_name                      = :email

    user.user_activation_mailer                       = UserMailer
    user.activation_token_attribute_name              = :activation_code
    user.activation_token_expires_at_attribute_name   = :activation_code_expires_at

    user.reset_password_mailer                        = UserMailer
    user.reset_password_expiration_period             = 10.minutes
    user.reset_password_time_between_emails           = nil

    user.activity_timeout                             = 1.minutes

    user.consecutive_login_retries_amount_limit       = 10
    user.login_lock_time_period                       = 2.minutes

    user.authentications_class                        = UserProvider
  end
end
