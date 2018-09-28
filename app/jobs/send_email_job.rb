
class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(booking, user)
  	BookingsMailer.booking_email(booking, user).deliver_later
  end
end
