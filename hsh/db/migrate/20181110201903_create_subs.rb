class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.date :fecha_inicio
      t.date :fecha_fin

      t.timestamps
    end
  end
end
