class Booking < ApplicationRecord
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
