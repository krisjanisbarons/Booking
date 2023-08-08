class BookingService
  attr_reader :booking, :date, :duration

  delegate :errors, to: :booking

  def initialize(booking, date, duration)
    @booking = booking
    @date = date
    @duration = duration
  end

  def reserve
    successfully_saved = false
    with_lock_on_booking_dates do
      successfully_saved = booking.save
    end

    broadcast_slots if successfully_saved

    successfully_saved
  end

  private

  def with_lock_on_booking_dates
    Booking.with_advisory_lock('booking') do
      yield
    end
  end

  def broadcast_slots
    BroadcastingService.new(booking, date, duration).notify
  end
end
