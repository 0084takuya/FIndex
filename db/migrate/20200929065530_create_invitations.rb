class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :code, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
