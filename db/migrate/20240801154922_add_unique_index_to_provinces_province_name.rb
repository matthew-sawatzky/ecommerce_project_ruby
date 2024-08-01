class AddUniqueIndexToProvincesProvinceName < ActiveRecord::Migration[6.1]
  def change
    add_index :provinces, :province_name, unique: true
  end
end
