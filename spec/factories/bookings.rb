FactoryBot.define do
  factory :booking do
    time_from { DateTime.current.beginning_of_hour }
    time_to { DateTime.current.beginning_of_hour + 30.minutes }
  end
end
