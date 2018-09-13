class CreateReservations < ActiveRecord::Migration[5.2]

	def change

		create_table :reservations do |t|

			t.belongs_to :listing
			t.belongs_to :user
			t.date :check_in
			t.date :check_out
			t.integer :guests
			t.timestamps

		end

	end


end