class Booking < ApplicationRecord
  validate :booking_overlap

	def self.bookings_for_two_days(date, duration)
    date_to = (date + duration.minutes) + 1.day
    date_range = (date.beginning_of_day..date_to)

    where(time_from: date_range).or(where(time_to: date_range))
  end

  def self.overlapp(booking)
    where(':start <= time_from AND :end >= time_to', start: booking.time_from, end: booking.time_to).or(
      where('time_from <= :start AND time_to > :start', start: booking.time_from)
    ).or(where('time_from < :end AND time_to >= :end', end: booking.time_to))
  end

  def booking_overlap
    return if Booking.overlapp(self).none?

    errors.add(:base, "Slot overlaps with a booking")
  end
end

# == Schema Information
#
# Table name: bookings
#
#  id         :uuid             not null, primary key
#  time_from  :datetime
#  time_to    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bookings_on_time_from_and_time_to  (time_from,time_to)
#
