class PlayerFirstMigration < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :name, :string, null: false
    add_column :players, :team, :string, null: false
    add_column :players, :position, :string, null: false
    add_column :players, :country, :string, null: false
    add_column :players, :age, :integer, null: false
    add_column :players, :height, :integer, null: false
    add_column :players, :weight, :integer, null: false
  end
end
