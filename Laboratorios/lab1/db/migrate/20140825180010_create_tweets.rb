class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :estado
      t.string :monstruo

      t.timestamps
    end
  end
end
