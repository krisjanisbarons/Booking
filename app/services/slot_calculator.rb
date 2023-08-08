class SlotCalculator
  attr_reader :date, :duration

  def initialize(date:, duration:)
    @date = date.to_time
    @duration = duration.to_i
  end

  def available_slots
    conditional_date = date
    slot_array = []

    begin
      slot_array << conditional_date unless unavailable_slot(conditional_date)

      conditional_date += 15.minutes
    end until conditional_date >= date + 1.day

    slot_array
  end

	def already_booked_slots
		Booking.bookings_for_two_days(date, duration)
	end

  private

  def unavailable_slot(from_date)
    to_date = from_date + duration.minutes

    already_booked_slots.any? do |slot|
      from_date.between?(slot.time_from, slot.time_to) ||
      (to_date).between?(slot.time_from, slot.time_to) ||
      (from_date < slot.time_from && slot.time_to < to_date)
    end
  end
end
