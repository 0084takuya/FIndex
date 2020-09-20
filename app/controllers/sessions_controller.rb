class SessionsController < ApplicationController
  def new
    @user = User.new
    render :layout => 'single'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      puts "login"
      log_in user
      redirect_to root_url
    else
      puts "fail"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
