class BookingService
  attr_reader :booking, :date, :duration

  delegate :errors, to: :booking

  def initialize(booking, date, duration)
    @booking = booking
    @date = date
    @duration = duration
  end

  def save_booking
    successfully_saved = false

    Booking.with_advisory_lock('booking') do
      successfully_saved = booking.save
    end

    broadcast_slots if successfully_saved

    successfully_saved
  end

  private

  def broadcast_slots
    BroadcastingService.new(booking, date, duration).broadcast
  end
end
