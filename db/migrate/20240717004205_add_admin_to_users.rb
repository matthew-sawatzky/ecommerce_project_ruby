class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :boolean, default: false
  end
end
