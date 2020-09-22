module PlayersHelper
  def player_id_to_name(player_id)
    player = Player.find(player_id)
    player.name
  end

  def user_player_stocks(player_id)
    UserStock.where(user_id: current_user.id, player_id: player_id).order(buy_price: :desc)
  end

  def user_player_stock_total(stocks)
    total_amount = 0
    stocks.each do |stock|
      total_amount += stock.amount
    end
    total_amount
  end
end
