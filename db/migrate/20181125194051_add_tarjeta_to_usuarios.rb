class AddTarjetaToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :tarjeta, :string
  end
end
