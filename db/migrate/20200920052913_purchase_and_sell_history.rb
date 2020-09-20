class PurchaseAndSellHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_history do |t|
      t.string :user_id, null: false
      t.string :player_id, null: false
      t.integer :amount, null: false
      t.integer :buy_price, null: false
      t.timestamps
    end

    create_table :sell_history do |t|
      t.string :user_id, null: false
      t.string :player_id, null: false
      t.integer :amount, null: false
      t.integer :sell_price, null: false
      t.integer :buy_price, null: false
      t.timestamps
    end
  end
end
