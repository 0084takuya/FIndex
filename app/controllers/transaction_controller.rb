class TransactionController < ApplicationController
    def buy
        puts "buy"
        player = Player.find_by(params[:player_id])
        buy_history = BuyHistory.new(
            user_id: current_user.id,
            player_id: player.id,
            amount: params[:amount].to_i,
            buy_price: player.buy_price,
        )
        
        if buy_history.save
            puts "success"
        else 
            puts "failed"
        end
    end
    
    def sell
        puts "sell"
        puts params
    end
end
