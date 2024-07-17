class AddTaxTypeToProvinces < ActiveRecord::Migration[7.1]
  def change
    add_column :provinces, :tax_type, :string
  end
end
