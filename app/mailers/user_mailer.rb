class UserMailer < ActionMailer::Base
  default_url_options[:host] = "0.0.0.0:3000"
  default :from => "notification@example.com"
  
  def password_reset_instructions(user)
    @user = user
    @url  = "http://example.com/login"
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end
end
