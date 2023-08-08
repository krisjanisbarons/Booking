module Api
  class BookingsController < ApplicationController
    include HasTimezone

    def create
      booking = Booking.new(time_from: params[:start_time], time_to: params[:end_time])
      booking_service = BookingService.new(booking, params[:date], params[:duration])

      if booking_service.save_booking
        render json: { success: true }
      else
        render json: { errors: booking_service.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
