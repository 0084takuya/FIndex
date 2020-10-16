module PlayersHelper
  def user_player_stock(player_id)
    UserStock.find_by(user_id: current_user.id, player_id: player_id)
  end

  def watch_list_to_players(watch_list)
    player_ids = []
    watch_list.each do |watch|
      continue if watch.player_id.nil?
      player_ids.push(watch.player_id)
    end
    Player.where(id: player_ids)
  end
  
  def recent_buy_histories
    BuyHistory.all.order(created_at: :desc).limit(5)
  end

end
