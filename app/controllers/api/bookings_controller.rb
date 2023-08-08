module Api
  class BookingsController < ApplicationController
    include HasTimezone

    def create
      booking = Booking.new(time_from: params[:start_time], time_to: params[:end_time])
      reserver = BookingService.new(booking, params[:date], params[:duration])

      if reserver.reserve
        render json: { success: true }
      else
        render json: { errors: reserver.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
