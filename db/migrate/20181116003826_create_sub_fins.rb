class CreateSubFins < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_fins do |t|
    	t.integer :valor
    	
      t.timestamps
    end
  end
end
