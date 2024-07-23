ActiveAdmin.register Card do
  permit_params :name, :name, :series, :description, :card_set_id

  filter :name
  filter :name
  filter :series
  filter :description
  filter :card_set

    index do
    selectable_column
    id_column
    column :name
    column :name
    column :series
    column :description
    column :card_set
    actions
  end

  form do |f|
    f.inputs 'Card Details' do
      f.input :name
      f.input :supertype
      f.input :subtype
      f.input :rarity
      f.input :card_set, as: :select, collection: CardSet.all
    end
    f.actions
  end
end
