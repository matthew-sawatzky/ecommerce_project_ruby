class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :supertype
      t.string :subtype
      t.string :rarity
      t.references :card_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
