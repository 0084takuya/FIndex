class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    render :layout => 'single'
  end

  def edit
  end

  def create
    if params[:user][:agree_term_of_service] == "0" then
      return
    end
    user = User.new(processed_params)
    if user.save
      puts "success"
    else 
      puts "failed" 
    end
  end

  private 
  def set_user
  end

  def processed_params
    attrs = user_params.to_h
    attrs[:birthday] = format_date(attrs[:birthday_year], attrs[:birthday_month], attrs[:birthday_day])
    puts attrs
    attrs
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name, :phone, :birthday_year, :birthday_month, :birthday_day, :invitation_code, :notification, :agree_term_of_service)
  end

  def format_date(year, month, day)
    Date.new(year.to_i, month.to_i, day.to_i)
  end 
end
