class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  activate_sorcery! do |config|
    config.sorcery_mailer = MyMailer
    config.username_attribute_name = :email
  end
  
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
