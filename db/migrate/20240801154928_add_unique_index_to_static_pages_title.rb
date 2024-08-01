class AddUniqueIndexToStaticPagesTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :static_pages, :title, unique: true
  end
end
