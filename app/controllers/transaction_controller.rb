class TransactionController < ApplicationController
  def buy
    player = Player.find(params[:player_id])
    invalid_flag = false
    amount = params[:amount].to_i
    user_stock = user_player_stock(player.id)

    if amount <= 0 
      invalid_flag = true
      flash[:notice] = "購入株数が不正です"  
    end

    if user_total_point(current_user) < player.buy_price * amount
      invalid_flag = true
      flash[:notice] = "所持コインが足りません"
    end

    if user_stock.nil? 
      if amount > 300
        invalid_flag = true
        flash[:notice] = "最大購入数が300です"
      end
    else
      if user_stock.amount + amount > 300
        invalid_flag = true
        flash[:notice] = "最大購入数が300です"
      end
    end

    if invalid_flag
      flash[:notice_title] = "購入に失敗しました"
      redirect_to player
      return
    end

    buy_cost = player.buy_price * amount

    # User point
    user_bonus_points = BonusPoint.where(user_id: current_user.id).order(created_at: :asc)

    user_bonus_points.each do |bonus_point|
      if buy_cost >= bonus_point.amount
        buy_cost -= bonus_point.amount
        bonus_point.destroy
      else
        bonus_point.amount -= buy_cost
        buy_cost = 0
        bonus_point.save
        break
      end
    end

    current_user.point -= buy_cost

    buy_history = BuyHistory.new(
      user_id: current_user.id,
      player_id: player.id,
      amount: amount,
      buy_price: player.buy_price,
    )
      
    if user_stock.present?
      user_stock.amount += amount
    else 
      user_stock = UserStock.new(
        user_id: current_user.id,
        player_id: player.id,
        amount: amount,
      )
    end

    # 株価システム
    has_changed_flag = false
    while true
      if amount < player.remaining_stock 
        player.remaining_stock -= amount
        break
      else
        amount -= player.remaining_stock
        player.raise_price
        has_changed_flag = true
      end
    end

    player.create_change_history if has_changed_flag

    if buy_history.invalid? || user_stock.invalid?
      flash[:notice_title] = "購入に失敗しました"  
      flash[:notice] = "エラーが発生しました"  
      redirect_to player
      return
    end

    player.save
    buy_history.save
    user_stock.save
    current_user.save validate: false

    flash[:notice] = "購入が完了しました！"  
    redirect_to player
  end
    
  def sell
    stock = user_player_stock(params[:player_id])
    player = Player.find(params[:player_id])
    invalid_flag = false

    sell_amount = params[:amount].to_i
    
    if stock.nil?
      invalid_flag = true
      flash[:notice] = "株式を保持していません"
      flash[:notice_title] = "売却に失敗しました"
      redirect_to player
      return
    end

    if stock.amount < sell_amount
      invalid_flag = true
      flash[:notice] = "売却株数が大きすぎます"
    end

    if sell_amount <= 0
      invalid_flag = true
      flash[:notice] = "売却株数が不正です"
    end

    if invalid_flag
      flash[:notice_title] = "売却に失敗しました"
      redirect_to player
      return
    end

    temp_sell_amount = sell_amount

    # 株価システム
    has_changed_flag = false
    while true
      if player.remaining_stock + temp_sell_amount < player.border_stock 
        player.remaining_stock += temp_sell_amount
        break
      else
        temp_sell_amount -= player.border_stock - player.remaining_stock
        player.lower_price
        has_changed_flag = true
      end
    end

    player.create_change_history if has_changed_flag

    stock.amount -= sell_amount
    
    stock.destroy if stock.amount == 0

    sell_history = SellHistory.new(
      user_id: current_user.id,
      player_id: player.id,
      amount: sell_amount,
      sell_price: player.sell_price
    )

    if !sell_history.save 
      flash[:notice_title] = "売却に失敗しました"
      flash[:notice] = "エラーが発生しました"
      redirect_to player
      return
    end
      
    current_user.point += sell_amount * player.sell_price

    stock.save
    player.save
    current_user.save validate: false

    flash[:notice] = "売却に完了しました！"
    redirect_to player
  end
end
