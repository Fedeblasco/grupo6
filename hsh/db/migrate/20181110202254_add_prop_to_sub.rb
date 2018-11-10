class AddPropToSub < ActiveRecord::Migration[5.2]
  def change
    add_reference :subs, :prop, foreign_key: true
  end
end
