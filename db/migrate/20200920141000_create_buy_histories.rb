class CreateBuyHistories < ActiveRecord::Migration[6.0]
  def change
    drop_table :buy_history
    drop_table :sell_history

    create_table :buy_histories do |t|
      t.string :user_id, null: false
      t.string :player_id, null: false
      t.integer :amount, null: false
      t.integer :buy_price, null: false
      t.timestamps
    end
  end
end
