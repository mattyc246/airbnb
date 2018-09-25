class AddTotalCostToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :total_cost, :decimal
  end
end
