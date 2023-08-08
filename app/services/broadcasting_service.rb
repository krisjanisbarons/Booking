class BroadcastingService
  attr_reader :booking, :date, :duration

  def initialize(booking, date, duration)
    @booking = booking
    @date = date
    @duration = duration
  end

  def broadcast
    broadcast_channel = "booking_#{booking.time_from.strftime("%m-%Y")}"
    Time.use_zone(nil) do
      ActionCable.server.broadcast(
        broadcast_channel,
        message
      )
    end
  end

  private

  def message
    available_slots = SlotCalculator.new(date: date, duration: duration).available_slots

    { slots: available_slots }
  end
end
