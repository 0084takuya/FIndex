class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    redirect_to action: :new
  end

  def show
    @sell_histories = SellHistory.where(user_id: @user.id).page(params[:user_purchase_page]).per(5).order(created_at: :desc)
    @user_stock = UserStock.where(user_id: @user.id).page(params[:user_stock_page]).per(10)
    
    @sort = params[:sort]
    puts @sort
    case params[:sort]
    when "買値昇順" then
      @user_stock = @user_stock.order(buy_price: :asc)
    when "買値降順" then
      @user_stock = @user_stock.order(buy_price: :desc)
    when "売値昇順" then
      @user_stock = @user_stock.order(sell_price: :asc)
    when "売値降順" then
      @user_stock = @user_stock.order(sell_price: :desc)
    else
      @sort = "全て"
    end
  end

  def new
    @user = User.new
    flash.now[:notice] = "ユーザ登録をしましょう" if response.redirect?
  end

  def edit
  end

  def create
    @user = User.new(processed_params)
    invalid_flag = false

    if params[:user][:agree_term_of_service] == "0" then
      flash.now[:notice] = "利用規約に同意してください"
      invalid_flag = true
    end

    begin
      if !@user.save
        flash.now[:notice] = "登録に失敗しました"
        invalid_flag = true
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:notice_title] = "登録に失敗しました"
      flash.now[:notice] = "既に登録されています"
      invalid_flag = true
    end

    if invalid_flag
      render :new
      return
    else 
      flash.now[:notice] = "登録完了しました！"
      log_in(@user)
      redirect_to @user
    end
  end

  private 
  def set_user
    @user = User.find_by(public_uid: params[:id])
    if current_user != @user
      flash[:notice_title] = "エラーが発生しました"
      flash[:notice] = "不正なアクセスです"
      redirect_to :root
      return
    end
  end

  def processed_params
    attrs = user_params.to_h
    attrs[:birthday] = format_date(attrs[:birthday_year], attrs[:birthday_month], attrs[:birthday_day])
    attrs[:last_login] = DateTime.now
    attrs[:phone] = attrs[:phone].delete("-")
    attrs[:point] = 10000
    attrs
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_name, :phone, :birthday_year, :birthday_month, :birthday_day, :invitation_code, :notification, :agree_term_of_service)
  end
end
