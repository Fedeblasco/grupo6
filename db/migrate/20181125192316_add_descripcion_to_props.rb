class AddDescripcionToProps < ActiveRecord::Migration[5.2]
  def change
    add_column :props, :descripcion, :string
  end
end
