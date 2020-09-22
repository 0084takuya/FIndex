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

  # change_historiesは新しい順で渡す
  def chart_data_from_change_histories(change_histories, default_price)
    datas = []
    turn_point = []
    price = default_price
    
    change_histories.each do |history|
      turn_point.push(history)
      price = history.new_value

      # 30日より前であった場合
      if history.created_at < 30.day.ago.beginning_of_day
        break
      end
    end

    turn_point = turn_point.reverse

    (0 ... 29).reverse_each do |i|
      while true
        if turn_point.count == 0
          break
        end
  
        if turn_point.first.created_at.strftime("%Y/%m/%d") == i.day.ago.beginning_of_day.strftime("%Y/%m/%d")
          price = turn_point.first.new_value
          turn_point.shift
        else
          break
        end
      end

      datas.push(price)
    end

    return datas
  end

  def recent_transaction
    BuyHistory.all.order(created_at: :desc).limit(5)
  end
end
