class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities do |t|
      t.string :facebook_id
      t.string :type

      t.timestamps
    end
  end
end
