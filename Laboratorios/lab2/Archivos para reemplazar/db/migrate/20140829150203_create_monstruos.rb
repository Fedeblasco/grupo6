class CreateMonstruos < ActiveRecord::Migration[5.1]
  def change
    create_table :monstruos do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
