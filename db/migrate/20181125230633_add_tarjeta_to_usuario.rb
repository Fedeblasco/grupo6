class AddTarjetaToUsuario < ActiveRecord::Migration[5.2]
  def change
  	add_column :usuarios, :tarjeta_numero, :string
  	add_column :usuarios, :tarjeta_cvv, :string
  	add_column :usuarios, :tarjeta_mes, :integer
  	add_column :usuarios, :tarjeta_ano, :integer
  end
end
