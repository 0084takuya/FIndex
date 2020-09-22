class ChangeTableNameChangeHistory < ActiveRecord::Migration[6.0]
  def change
    rename_table :change_history, :change_histories
  end
end
