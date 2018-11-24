class CreateHotSales < ActiveRecord::Migration[5.2]
  def change
    create_table :hot_sales do |t|

      t.timestamps
    end
  end
end
