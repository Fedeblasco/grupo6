class AddFechaNacToUsuario < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :fecha_nac, :Date
  end
end
