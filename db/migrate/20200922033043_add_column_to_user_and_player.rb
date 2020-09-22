class AddColumnToUserAndPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :remaining_stock, :integer, null: false, default: 0
    add_column :players, :border_stock, :integer, null: false, default: 100
    add_column :players, :image_name, :string
    add_column :users, :coin, :integer, default: 0

    create_table :change_history do |t|
      t.references :player, null: false
      t.integer :new_value, null: false

      t.timestamps
    end
  end
end
