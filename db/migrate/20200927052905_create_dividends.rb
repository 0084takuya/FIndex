class CreateDividends < ActiveRecord::Migration[6.0]
  def change
    create_table :dividends do |t|
      t.references :player_id, null: false
      t.integer :amount, null: false
      t.string :detail

      t.timestamps
    end
  end
end
