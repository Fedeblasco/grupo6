class AddPrecioToProp < ActiveRecord::Migration[5.2]
  def change
  	add_column :props, :precio, :integer
  end
end
