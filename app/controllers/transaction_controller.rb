class TransactionController < ApplicationController
    include PlayersHelper

    def buy
        puts "buy"
        player = Player.find(params[:player_id])
        amount = params[:amount].to_i

        if amount == 0 
            puts "failed"
            return
        end

        if current_user.point < player.buy_price * amount
            puts "failed"
            return
        end

        current_user.point -= player.buy_price * amount

        buy_history = BuyHistory.new(
            user_id: current_user.id,
            player_id: player.id,
            amount: amount,
            buy_price: player.buy_price,
        )
        
        user_stock = UserStock.new(
            user_id: current_user.id,
            player_id: player.id,
            amount: amount,
            buy_price: player.buy_price,
        )

        # 株価システム
        while true
            puts amount
            if amount < player.remaining_stock 
                player.remaining_stock -= amount
                break
            else
                amount -= player.remaining_stock
                player.raise_price
            end
        end

        if buy_history.invalid? || user_stock.invalid?
            puts "failed"
            return
        end

        player.save
        buy_history.save
        user_stock.save
        current_user.save
    end
    
    def sell
        puts "sell"
        stocks = user_player_stocks(params[:player_id])
        player = Player.find(params[:player_id])
        sell_amount = params[:amount].to_i

        if stocks.nil?
            puts "failed"
            # 保有していない
            return
        end

        if user_player_stock_total(stocks) < sell_amount
            puts "failed"
            # 保有している株式が足りない
            return
        end

        # 株価システム
        while true
            if player.remaining_stock + sell_amount < player.border_stock 
                player.remaining_stock += sell_amount
                break
            else
                sell_amount -= player.border_stock - player.remaining_stock
                player.lower_price
            end
        end

        stocks.each do |stock|
            if sell_amount == 0 
                break
            end

            sold_amount = 0
            if stock.amount > sell_amount
                stock.amount -= sell_amount
                sold_amount = sell_amount
                sell_amount = 0
                stock.save
            else
                sell_amount -= stock.amount
                sold_amount = stock.amount
                stock.destroy
            end
            
            sell_history = SellHistory.new(
                user_id: current_user.id,
                player_id: player.id,
                amount: sold_amount,
                buy_price: stock.buy_price,
                sell_price: player.sell_price
            )

            if !sell_history.save
                puts "failed"
                return
            end
            
            current_user.point += sold_amount * player.sell_price
        end

        player.save
        current_user.save
        puts "sold"
    end
end
