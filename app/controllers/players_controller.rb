class PlayersController < ApplicationController
  def index
    @players = Player.all
    gon.players = @players
  end

  def show
    @player = Player.find_by(params[:id])
    gon.player = @player
  end 
end
