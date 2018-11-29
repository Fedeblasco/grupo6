class AddColumnsToCarousel < ActiveRecord::Migration[5.2]
  def change
  	 add_column :carousels, :texto1fto1, :string
   	 add_column :carousels, :texto2fto1, :string
     add_column :carousels, :texto1fto2, :string
   	 add_column :carousels, :texto2fto2, :string
     add_column :carousels, :texto1fto3, :string
     add_column :carousels, :texto2fto3, :string
  end
end
