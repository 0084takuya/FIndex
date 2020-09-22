class CreateUserStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stocks do |t|
      t.references :user, null: false
      t.references :player, null: false
      t.integer :amount, null: false
      t.integer :buy_price, null: false

      t.timestamps
    end
  end
end
