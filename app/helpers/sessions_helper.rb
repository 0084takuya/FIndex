module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    user_stocks = UserStock.where(user_id: user.id)
    user_stocks_player_ids = user_stocks.pluck(:player_id)

    if user.last_login.present? and user_stocks_player_ids.present?
      dividends = Dividend.where(created_at: user.last_login .. DateTime.now).where(player_id: user_stocks_player_ids)

      dividends.each do |dividend|
        stock = user_stocks.find_by(user_id: user.id, player_id: dividend.player_id)

        if stock.nil?
          flash[:notice] = "配当金の受け取りに失敗しました。"
          return
        end

        user.point += dividend.amount * stock.amount
      end
    end

    user.last_login = DateTime.now
    user.save validate: false
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
