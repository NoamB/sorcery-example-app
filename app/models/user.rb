class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  activate_sorcery! do |config|
    config.username_attribute_name                      = :email
    
    config.user_activation_mailer                       = UserMailer
    config.activation_token_attribute_name              = :activation_code
    config.activation_token_expires_at_attribute_name   = :activation_code_expires_at
    
    config.reset_password_mailer                        = UserMailer
    config.reset_password_expiration_period             = 10.minutes
    config.reset_password_time_between_emails           = nil
        
    config.activity_timeout                             = 1.minutes
  
    config.consecutive_login_retries_amount_limit       = 10
    config.login_lock_time_period                       = 2.minutes
  end
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
