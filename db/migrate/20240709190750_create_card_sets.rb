class CreateCardSets < ActiveRecord::Migration[6.0]
  def change
    create_table :card_sets do |t|
      t.string :set_name, null: false, unique: true
      t.string :set_series, null: false

      t.timestamps
    end
  end
end
