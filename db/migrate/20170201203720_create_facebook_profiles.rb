class CreateFacebookProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :facebook_profiles do |t|
      t.string :facebook_id
      t.string :type

      t.timestamps
    end
  end
end
