class PlayersController < ApplicationController
  include ChartHelper

  def index
    @sort = params[:sort]
    @team = params[:team]
    @search = params[:search]
    @position = params[:position]
    
    case params[:sort]
    when "買値昇順" then
      @players = Player.page(params[:page]).buy_asc
    when "買値降順" then
      @players = Player.page(params[:page]).buy_desc
    when "売値昇順" then
      @players = Player.page(params[:page]).sell_asc
    when "売値降順" then
      @players = Player.page(params[:page]).sell_desc
    when "監視中" then
      watch_list = Watch.where(user_id: current_user.id)
      @players = watch_list_to_players(watch_list).page(params[:page])
    else 
      @players = Player.page(params[:page])
      @sort = "全て"
    end

    if @team.present?
      @players = @players.where(team: @team)
    end

    if @position.present?
      @players = @players.where(position: @position)
    end

    if @search.present?
      @players = @players.search_columns(@search)
    end
  end

  def show
    @player = Player.find(params[:id])
    change_histories = ChangeHistory.where(player_id: params[:id]).order(created_at: :asc)
    gon.player = @player
    gon.data = chart_data(change_histories, @player.buy_price)
    gon.options = chart_option
  end 

end