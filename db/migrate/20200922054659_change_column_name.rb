class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :players, :ask_price, :sell_price
    rename_column :users, :coin, :point
  end
end
