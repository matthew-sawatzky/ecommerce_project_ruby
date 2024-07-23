ActiveAdmin.register CardSet do
  permit_params :name, :series

  index do
    selectable_column
    id_column
    column :name
    column :series
    actions
  end

  filter :name
  filter :series

  form do |f|
    f.inputs 'Card Set Details' do
      f.input :name
      f.input :series
    end
    f.actions
  end
end
