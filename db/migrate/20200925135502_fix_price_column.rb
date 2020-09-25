class FixPriceColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :players, :price, :decimal, precision: 10, scale: 5, null: false
  end
end
