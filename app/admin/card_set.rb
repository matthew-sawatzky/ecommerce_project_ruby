ActiveAdmin.register CardSet do
  permit_params :name, :series


    filter :name
    filter :series


  index do
    selectable_column
    id_column
    column :name
    column :series
    actions
  end

  form do |f|
    f.inputs 'Card Set Details' do
      f.input :name
      f.input :series
    end
    f.actions
  end
end
