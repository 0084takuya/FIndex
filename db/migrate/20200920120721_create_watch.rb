class CreateWatch < ActiveRecord::Migration[6.0]
  def change
    drop_table :watches

    create_table :watches do |t|
      t.references :user, null: false
      t.references :player, null: false

      t.timestamps
    end

    drop_table :watch_lists
  end
end
