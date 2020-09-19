class UserFirstMigration < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, null: false
    add_column :users, :password_digest, :string, null: false
    add_column :users, :phone, :string, null: false
    add_column :users, :user_name, :string, null: false
    add_column :users, :birthday, :date, null: false
    add_column :users, :notification, :boolean, null: false
  end
end
