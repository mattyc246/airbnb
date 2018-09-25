class DropReservations < ActiveRecord::Migration[5.2]
  def change
   drop_table :reservations
  end
end
