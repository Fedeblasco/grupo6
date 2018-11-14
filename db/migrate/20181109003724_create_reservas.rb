class CreateReservas < ActiveRecord::Migration[5.2]
  def change
    create_table :reservas do |t|
      t.date :fecha

      t.timestamps
    end
  end
end
