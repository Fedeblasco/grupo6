class AddOcultoToProps < ActiveRecord::Migration[5.2]
  def change
    add_column :props, :oculto, :boolean
  end
end
