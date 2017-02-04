class CreateFacebookMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :facebook_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :text
      t.string :mid
      t.integer :seq
      t.datetime :timestamp

      t.timestamps
    end
  end
end
