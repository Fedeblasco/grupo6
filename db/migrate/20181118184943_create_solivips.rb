class CreateSolivips < ActiveRecord::Migration[5.2]
  def change
    create_table :solivips do |t|
      t.string :estado

      t.timestamps
    end
  end
end
