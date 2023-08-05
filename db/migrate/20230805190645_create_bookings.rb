class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime :time_from
      t.datetime :time_to
      t.index [:time_from, :time_to]

      t.timestamps
    end
  end
end
