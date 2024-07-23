class AddPriceToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :price, :decimal
  end
end
