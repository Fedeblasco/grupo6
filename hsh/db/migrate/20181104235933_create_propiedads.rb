class CreatePropiedads < ActiveRecord::Migration[5.2]
  def change
    create_table :propiedads do |t|
      t.string :nombre
      t.string :ubicacion

      t.timestamps
    end
  end
end
