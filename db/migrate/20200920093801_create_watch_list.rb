class CreateWatchList < ActiveRecord::Migration[6.0]
  def change
    create_table :watch_lists do |t|
      t.references :user, null: false
      t.references :player, null: false

      t.timestamps
    end
  end
end
