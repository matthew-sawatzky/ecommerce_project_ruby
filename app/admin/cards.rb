ActiveAdmin.register Card do
  # See permitted parameters documentation:
  # https://activeadmin.info/customizing-strong-parameters.html

  # Permit parameters for form fields
  permit_params :name, :set_name, :set_series, :description, :image_url
  
  # Index page configuration
  index do
    selectable_column
    id_column
    column :name
    column :set_name
    column :set_series
    column :description
    column :image_url
    actions
  end

  # Form configuration
  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :set_name
      f.input :set_series
      f.input :description
      f.input :image_url
    end
    f.actions
  end
end
