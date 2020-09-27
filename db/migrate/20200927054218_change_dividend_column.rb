class ChangeDividendColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :dividends, :player_id_id, :player_id
  end
end
