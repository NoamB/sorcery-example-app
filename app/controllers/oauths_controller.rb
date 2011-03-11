class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    auth_at_provider(params[:provider])
  end
  
  def callback
    provider = params[:provider]
    if @user = login_from_access_token(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from_provider!(provider)
        @user.activate!
        reset_session # protect from session fixation attack
        login_user(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
end