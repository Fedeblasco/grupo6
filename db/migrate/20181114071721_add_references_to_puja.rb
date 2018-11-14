class AddReferencesToPuja < ActiveRecord::Migration[5.2]
  def change
    add_reference :pujas, :usuario, foreign_key: true
    add_reference :pujas, :sub, foreign_key: true
  end
end
