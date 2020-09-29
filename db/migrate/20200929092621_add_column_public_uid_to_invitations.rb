class AddColumnPublicUidToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :public_uid, :string
    add_index  :invitations, :public_uid, unique: true
  end
end
