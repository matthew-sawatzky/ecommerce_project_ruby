class CreateSets < ActiveRecord::Migration[7.1]
  def change
    create_table :sets do |t|
      t.string :set_name
      t.string :set_series

      t.timestamps
    end
  end
end
