class SessionsController < ApplicationController
  def new
    @user = User.new
    render :layout => 'single'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "ログインしました！"
      redirect_to root_url
    else
      flash.now[:notice] = "ログインに失敗しました。"
      render 'new', :layout => 'single'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
