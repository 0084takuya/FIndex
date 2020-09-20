class AddPlayerColumn1 < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :ask_price, :integer, null: false
    add_column :players, :buy_price, :integer, null: false
  end
end
