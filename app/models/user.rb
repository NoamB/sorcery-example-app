class User
  include Mongoid::Document

  attr_accessible :email, :password, :password_confirmation
  
  has_many :providers, :class_name => "UserProvider", :dependent => :destroy

  authenticates_with_sorcery!
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
