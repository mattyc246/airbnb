class CreateListings < ActiveRecord::Migration[5.2]

	def change

		create_table :listings do |t|

			t.string :listing_name
			t.string :location
			t.belongs_to :user
			t.text :feature
			t.timestamps


		end

	end
end