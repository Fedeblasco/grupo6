class AddHotsaleToProp < ActiveRecord::Migration[5.2]
  def change
    add_column :props, :hotsale, :boolean
  end
end
