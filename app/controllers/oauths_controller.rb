class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  # sends the user on a trip to twitter,
  # and after authorizing there back to the callback url.
  def twitter
    auth_at_provider(:twitter)
  end
  
  def twitter_callback
    if @user = login_from_access_token(:twitter)
      redirect_to root_path, :notice => "Logged in from Twitter!"
    else
      begin
        @user_hash = get_user_hash(:twitter)
        p @user_hash
        @user = User.create!(:email => @user_hash[:user_info]["screen_name"], 
                             :providers_attributes => [{
                               :provider => :twitter, 
                               :uid => @user_hash[:uid]
                             }])
        @user.activate!
        reset_session # protect from session fixation attack
        login_user(@user)
        redirect_to root_path, :notice => "Logged in from Twitter!"
      #rescue
      #  redirect_to root_path, :alert => "Failed to login from Twitter!"
      end
    end
  end
  
  def facebook
    auth_at_provider(:facebook)    
  end
  
  def facebook_callback
    if @user = login_from_access_token(:facebook)
      redirect_to root_path, :notice => "Logged in from Facebook!"
    else
      begin
        @user_hash = get_user_hash(:facebook)
        p @user_hash
        @user = User.create!(:email => @user_hash[:user_info]["name"], 
                             :providers_attributes => [{
                               :provider => :facebook, 
                               :uid => @user_hash[:uid]
                             }])
        @user.activate!
        reset_session # protect from session fixation attack
        login_user(@user)
        redirect_to root_path, :notice => "Logged in from Facebook!"
      #rescue
      #  redirect_to root_path, :alert => "Failed to login from Facebook!"
      end
    end  
  end
end