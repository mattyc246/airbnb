class AddPaymentStatusToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :payment_status, :boolean
  end
end
