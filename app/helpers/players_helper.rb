module PlayersHelper
  def user_player_stock(player_id)
    UserStock.find_by(user_id: current_user.id, player_id: player_id)
  end

  def watch_list_to_players(watch_list)
    player_ids = []
    watch_list.each do |watch|
      player_ids.push(watch.player_id)
    end
    Player.where(id: player_ids)
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

  def recent_buy_histories
    BuyHistory.all.order(created_at: :desc).limit(5)
  end

end
