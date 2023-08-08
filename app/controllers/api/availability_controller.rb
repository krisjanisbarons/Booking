module Api
  class AvailabilityController < ::ApplicationController
    include HasTimezone

    def index
      date = Date.parse(params[:date])
      duration = params[:duration]

      available_slots = SlotCalculator.new(date: date, duration: duration).available_slots

      render json: available_slots
    end
  end
end
