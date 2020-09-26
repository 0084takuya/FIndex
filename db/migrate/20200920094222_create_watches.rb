class CreateWatches < ActiveRecord::Migration[6.0]
  def change
    create_table :watches do |t|
      t.references :user, null: false
      t.references :player, null: false
      t.timestamps
    end
  end
end
