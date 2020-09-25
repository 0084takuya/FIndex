class ChangeSellHistory < ActiveRecord::Migration[6.0]
  def change
    remove_column :sell_histories, :buy_price
  end
end
