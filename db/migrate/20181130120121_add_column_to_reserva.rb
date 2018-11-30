class AddColumnToReserva < ActiveRecord::Migration[5.2]
  def change
  	add_column :reservas, :normal, :boolean
  end
end
