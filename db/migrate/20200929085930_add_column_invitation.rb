class AddColumnInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :owner_id, :integer, null: false
  end
end
