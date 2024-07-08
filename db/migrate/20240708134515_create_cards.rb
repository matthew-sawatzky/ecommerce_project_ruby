class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :card_name
      t.string :card_supertype
      t.string :card_subtypes
      t.string :card_set
      t.string :card_rarity
      t.string :card_image
      t.references :set, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
