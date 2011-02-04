class UserSessionsController < ApplicationController
  skip_before_filter :require_user_login, :except => [:destroy]
  
  def new
    @user = User.new
  end

  def create
    success_url = session[:user_wanted_url] ? session[:user_wanted_url] : :users
    respond_to do |format|
      if @user = login(params[:email],params[:password],params[:remember])
        format.html { redirect_to(success_url, :notice => 'Login successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    logout
    redirect_to(:users, :notice => 'Logged out!')
  end

end
