class WatchController < ApplicationController
  def create
    user = current_user
    player = Player.find(params[:player_id])
    if Watch.create(user_id: user.id, player_id: player.id)
      puts "created"
    else
      puts "failed"
    end
  end

  def destroy
    user = current_user
    player = Player.find(params[:player_id])
    if watch = Watch.find_by(user_id: user.id, player_id: player.id)
      watch.delete
      puts "destroyed"
    else
      puts "failed"
    end
  end
end
