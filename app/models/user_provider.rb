class UserProvider
  include Mongoid::Document
  belongs_to :user
end