class AddColsToHotsale < ActiveRecord::Migration[5.2]
  def change
  	add_column :hot_sales, :precio, :integer
  	add_column :hot_sales, :fecha_hotsale, :date
  	add_column :hot_sales, :fecha_reserva, :date

  	add_reference :hot_sales, :prop, foreign_key: true
  end
end
