class BroadcastingService
  attr_reader :booking, :date, :duration

  def initialize(booking, date, duration)
    @booking = booking
    @date = date
    @duration = duration
  end

  def notify
    Time.use_zone(nil) do
      ActionCable.server.broadcast(
        "booking_#{booking.time_from.strftime("%m-%Y")}",
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
