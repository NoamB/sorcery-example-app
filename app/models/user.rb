class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :providers_attributes
  
  has_many :providers, :class_name => "UserProvider", :dependent => :destroy
  accepts_nested_attributes_for :providers

  authenticates_with_sorcery!
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
