class User
  include Mongoid::Document
  field :username, type: String
  field :email, type: String
  field :salt, type: String
  field :crypted_password, type: String
  field :reset_password_token, type: String
  field :reset_password_token_expires_at, type: DateTime
  field :reset_password_email_sent_at, type: DateTime
  field :remember_me_token, type: String
  field :remember_me_token_expires_at, type: DateTime
  field :activation_code, type: String
  field :activation_state, type: String
  field :activation_token_expires_at, type: DateTime
  field :lock_expires_at, type: DateTime
  field :last_login_at, type: DateTime
  field :failed_logins_count, type: Integer
  field :last_activity_at, type: DateTime
  field :last_logout_at, type: DateTime
  attr_accessible :email, :password, :password_confirmation
  
  has_many :providers, :class_name => "UserProvider", :dependent => :destroy

  authenticates_with_sorcery!
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
end
