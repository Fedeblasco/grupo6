class AddRelationToSubFin < ActiveRecord::Migration[5.2]
  def change
    add_reference :sub_fins, :usuario , foreign_key: true
    add_reference :sub_fins, :reserva , foreign_key: true
  end
end
