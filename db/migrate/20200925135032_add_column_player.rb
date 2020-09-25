class AddColumnPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :price, :decimal, precision: 10, scale: 5
  end
end
