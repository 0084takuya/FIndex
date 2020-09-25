class WatchController < ApplicationController
  def create
    user = current_user
    player = Player.find(params[:player_id])
    if Watch.create(user_id: user.id, player_id: player.id)
      flash[:notice] = "監視中に登録しました"
    else
      flash[:notice] = "エラー"
    end
    redirect_back fallback_location: :root
  end

  def destroy
    user = current_user
    player = Player.find(params[:player_id])
    if watch = Watch.find_by(user_id: user.id, player_id: player.id)
      watch.delete
      flash[:notice] = "監視中から解除しました"
    else
      flash[:notice] = "エラー"
    end
    redirect_back fallback_location: :root
  end
end
