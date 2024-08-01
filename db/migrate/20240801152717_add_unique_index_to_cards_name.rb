class AddUniqueIndexToCardsName < ActiveRecord::Migration[6.0]
  def change
    add_index :cards, :name, unique: true
  end
end
