class AddPrecioMinToSub < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :precio_min, :integer
  end
end
