module PlayersHelper
  def player_id_to_player(player_id)
    player = Player.find(player_id)
    player
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

  def chart_data_from_change_histories(change_histories)
    datas = []
    change_histories.each do |history|
      # 30日より前であった場合
      if history.created_at < 30.day.ago.beginning_of_day
        
      end
    end
    return datas
  end

  def recent_transaction
    BuyHistory.all.order(created_at: :desc).limit(5)
  end
end
