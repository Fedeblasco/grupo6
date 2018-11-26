class AgregarNobmreApellido < ActiveRecord::Migration[5.2]
  def change
  	add_column :usuarios, :nombre, :string
  	add_column :usuarios, :apellido, :string
  end
end
