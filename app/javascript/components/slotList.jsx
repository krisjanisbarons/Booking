import React, { useState } from 'react'
import axios from 'axios'
import { TIMEZONE } from '../hooks/useSlots'
import { addMinutes, format, parseISO } from 'date-fns'
import { Dialog } from 'primereact/dialog'

export const SlotList = ({ date, availableSlots, duration }) => {
  const [errorMessage, setErrorMessage] = useState('')
  const [confirmationOpen, setConfirmationOpen] = useState(false)

  const handleBooking = (slot) => {
    axios
      .post('/api/bookings', {
        start_time: slot,
        end_time: addMinutes(slot, duration),
        date: format(date, 'dd-MM-yyyy'),
        duration: duration,
        timezone: TIMEZONE
      })
      .then(({ data: { success } }) => setConfirmationOpen(success))
      .catch((error) => {
        setErrorMessage(error?.response?.errors?.join(',') ?? 'System error')
      })
  }

  return (
    <>
      <Dialog
        header='Booking'
        visible={confirmationOpen}
        style={{ width: '50vw' }}
        onHide={() => setConfirmationOpen(false)}
      >
        <p className="m-0">
          You have successfully booked a slot!
        </p>
      </Dialog>
      {errorMessage && (
        <div>
          {errorMessage}
        </div>
      )}
      <div className='slot-wrapper'>
        <div>
          <h4>Book time</h4>
        </div>
        <div className='time-slots'>
          {availableSlots.map((slot) => {
            const time = parseISO(slot)
            return (
              <button
                key={time}
                className='slot-button'
                onClick={() => handleBooking(time)}
              >
                {format(time, 'HH:mm')}
              </button>
            )
          })}
        </div>
      </div>
    </>
  )
}

