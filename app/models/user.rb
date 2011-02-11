class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  activate_sorcery! do |config|
    config.user_activation_mailer = UserMailer
    config.reset_password_mailer = UserMailer
    config.username_attribute_name = :email
    config.activity_timeout = 1.minutes
  end
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
