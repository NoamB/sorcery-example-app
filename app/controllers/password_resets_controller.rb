class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate

  def create # request password reset
    @user = User.find_by_email(params[:email])
    
    @user.reset_password! if @user
    
    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
  end

  def edit
    @user = User.find(params[:id])
    @code = params[:c]
    not_authenticated if @user.reset_password_code != @code
  end
  
  def update
    @user = User.find(params[:id])
    @code = params[:code]
    if @code = @user.reset_password_code && @user.update_attributes(params[:user])
      redirect_to(root_path, :notice => 'Password was successfully updated.')
    else
      render :action => "edit"
    end
  end

end
