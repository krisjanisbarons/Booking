require 'rails_helper'

RSpec.describe Booking do
  let(:date) { DateTime.current.beginning_of_day }
	let!(:existing_booking) { create :booking, time_from: date, time_to: date + 1.hour }

  describe 'validation' do
    subject { booking.valid? }

    let(:booking) { build :booking, time_from: date + 2.hours, time_to: date + 1.day }

    it { is_expected.to eq(true) }

    context 'slot ends at the start of another booking' do
      let(:booking) { build :booking, time_from: date - 1.hour, time_to: date }
      it { is_expected.to eq(true) }
    end

    context 'slot starts at the end of another booking' do
      let(:booking) { build :booking, time_from: date + 1.hour, time_to: date + 2.hours }
      it { is_expected.to eq(true) }
    end

    context 'time_from in another booking' do
      let(:booking) { build :booking, time_from: date + 30.minutes, time_to: date + 1.day }
      it { is_expected.to eq(false) }
    end

    context 'time_to in another booking' do
      let(:booking) { build :booking, time_from: date - 1.hour, time_to: date + 30.minutes }
      it { is_expected.to eq(false) }
    end

    context 'with the booking booked around already booking' do
      let(:booking) { build :booking, time_from: date - 1.hour, time_to: date + 3.hours }
      it { is_expected.to eq(false) }
    end
  end
end
