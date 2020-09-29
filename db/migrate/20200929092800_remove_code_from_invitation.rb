class RemoveCodeFromInvitation < ActiveRecord::Migration[6.0]
  def change
    remove_column :invitations, :code
  end
end
