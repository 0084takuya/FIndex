class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    redirect_to action: :new
  end

  def show
    @sell_histories = SellHistory.where(user_id: @user.id)
    @user_stock = UserStock.where(user_id: @user.id)
    
    @sort = params[:sort]
    puts @sort
    case params[:sort]
    when "買値昇順" then
      @user_stock = @user_stock.order(buy_price: :asc)
    when "買値降順" then
      @user_stock = @user_stock.order(buy_price: :desc)
    else
      @sort = "全て"
    end
  end

  def new
    @user = User.new
    render :layout => 'single'
  end

  def edit
  end

  def create
    @user = User.new(processed_params)
    invalid_flag = false

    if params[:user][:agree_term_of_service] == "0" then
      flash[:notice] = "利用規約に同意してください。"
      invalid_flag = true
    end

    if !@user.save
      flash[:notice] = "登録に失敗しました。"
      invalid_flag = true
    end

    if invalid_flag
      render :new, :layout => 'single'
      return
    else 
      flash[:notice] = "登録完了しました！"
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  private 
  def set_user
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to :root
      return
    end
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
end
