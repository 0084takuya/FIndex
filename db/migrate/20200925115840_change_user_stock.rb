class ChangeUserStock < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_stocks, :buy_price
  end
end
