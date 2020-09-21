module PlayersHelper
  def player_id_to_name(id)
    player = Player.find(id)
    player.name
  end
end
