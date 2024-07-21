class CreateCardSets < ActiveRecord::Migration[6.1]
  def change
    create_table :card_sets do |t|
      t.string :name
      t.string :series

      t.timestamps
    end
  end
end
