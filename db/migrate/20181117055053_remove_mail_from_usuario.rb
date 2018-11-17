class RemoveMailFromUsuario < ActiveRecord::Migration[5.2]
  def change
  	remove_column :usuarios, :mail
  end
end
