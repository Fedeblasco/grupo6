class AddReferencesToReserva < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservas, :usuario, foreign_key: true
    add_reference :reservas, :prop, foreign_key: true
  end
end
