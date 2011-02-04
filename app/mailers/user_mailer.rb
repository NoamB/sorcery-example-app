class UserMailer < ActionMailer::Base
  
  default :from => "notifications@example.com"
  
  def activation_needed_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/users/activate?c=#{user.activation_code}"
    mail(:to => user.email,
         :subject => "Welcome to My Awesome Site")
  end
  
  def activation_success_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/login"
    mail(:to => user.email,
         :subject => "Your account is now activated")
  end
  
  def reset_password_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/password_resets/#{user.id}/edit?c=#{user.reset_password_code}"
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end
end