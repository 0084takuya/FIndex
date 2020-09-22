class PlayersController < ApplicationController

  def index
    @sort = params[:sort]
    case params[:sort]
    when "買値昇順" then
      @players = Player.page(params[:page]).buy_asc
    when "買値降順" then
      @players = Player.page(params[:page]).buy_desc
    when "売値昇順" then
      @players = Player.page(params[:page]).sell_asc
    when "売値降順" then
      @players = Player.page(params[:page]).sell_desc
    else 
      @players = Player.page(params[:page])
      @sort = "全て"
    end
  end

  def show
    @player = Player.find(params[:id])
    gon.player = @player

    @change_histories = @player.change_histories
    gon.change_histories = @change_histories
  end 
end