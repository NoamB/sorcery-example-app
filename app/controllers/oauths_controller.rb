class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  # sends the user on a trip to twitter,
  # and after authorizing there back to the callback url.
  def twitter
    auth_at_provider(:twitter)
  end
  
  def twitter_callback
    if @user = login_from_access_token
      redirect_to root_path, :notice => "Logged in from Twitter!"
    else
      begin
        @user_hash = get_user_hash(:twitter)
        @user = User.create!(:email => @user_hash["screen_name"], 
                             :providers_attributes => [{
                               :provider => :twitter, 
                               :access_token => @access_token.token, 
                               :access_token_secret => @access_token.secret
                             }])
        @user.activate!
        reset_session # protect from session fixation attack
        login_user(@user)
        redirect_to root_path, :notice => "Logged in from Twitter!"
      rescue
        redirect_to root_path, :alert => "Failed to login from Twitter!"
      end
    end
  end
end