class AddNameToFacebookProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :facebook_profiles, :name, :string
  end
end
