class AddAvatarsToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :avatars, :json
  end
end
