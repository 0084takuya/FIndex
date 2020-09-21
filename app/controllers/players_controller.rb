class PlayersController < ApplicationController

  def index
    @sort = params[:sort]
    case params[:sort]
    when "買値昇順" then
      @players = Player.buy_asc
    when "買値降順" then
      @players = Player.buy_desc
    when "売値昇順" then
      @players = Player.sell_asc
    when "売値降順" then
      @players = Player.sell_desc
    else 
      @players = Player.page(params[:page])
      @sort = "全て"
    end
  end

  def show
    @player = Player.find_by(params[:id])
    gon.player = @player
  end 
end
