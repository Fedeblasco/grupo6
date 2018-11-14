class AddFechaReservaToSub < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :fecha_reserva, :date
  end
end
