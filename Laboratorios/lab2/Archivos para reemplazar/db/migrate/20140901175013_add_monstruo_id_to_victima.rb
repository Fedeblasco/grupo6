class AddMonstruoIdToVictima < ActiveRecord::Migration[5.1]
  def change
    add_column :victimas, :monstruo_id, :integer
  end
end
