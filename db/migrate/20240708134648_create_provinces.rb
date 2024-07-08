class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.integer :provincial_tax
      t.integer :federal_tax

      t.timestamps
    end
  end
end
