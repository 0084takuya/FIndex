class CreateBonusPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :bonus_points do |t|
      t.references :user, null: false
      t.integer :amount, null: false
      t.datetime :expire_at
      t.timestamps
    end
  end
end
