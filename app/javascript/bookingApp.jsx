import React, { useState } from 'react'
import ReactDOM from 'react-dom/client'
import { PrimeReactProvider } from 'primereact/api'
import { Calendar } from 'primereact/calendar'
import { useSlots } from './hooks/useSlots'
import { SlotList } from './components/slotList'
import { isEmpty } from 'lodash'
import axios from 'axios'

const BookingApp = () => {
  const [date, setDate] = useState(new Date())
  const [duration, setDuration] = useState(1)
  const { availableSlots, errorMessage } = useSlots(date, duration)

  return (
    <PrimeReactProvider>
      <div className='app-wrapper'>
        <div className='calendar-wrapper'>
          {errorMessage && (
            errorMessage
          )}
          <div className='booking-duration-wrapper'>
            <h5>Choose booking duration</h5>
            <input
              className='html-duration-picker'
              data-duration='00:15'
              data-duration-max="24:00"
              data-duration-min="00:01"
              data-hide-seconds
              onChange={(e) => {
                const [hours, minutes] = e.currentTarget?.value?.split(':').map(Number)
                const durationMinutes = (minutes ?? 0) + (hours ?? 0) * 60

                return setDuration(durationMinutes)
              }}
            />
          </div>
          <Calendar
            value={date}
            onChange={(e) => setDate(e.value)}
            minDate={new Date()}
            touchUI
            inline
            autoFocus
          />
        </div>
        {!isEmpty(availableSlots) && (
          <SlotList date={date} availableSlots={availableSlots} duration={duration} />
        )}
      </div>
    </PrimeReactProvider>
  )
}

const metaTag = document.querySelector(`meta[name='csrf-token']`)
const crsfToken = metaTag ? metaTag.getAttribute('content') : null
axios.defaults.headers.common['X-CSRF-Token'] = crsfToken

const root = document.getElementById('booking-wrapper')
if (root) {
  ReactDOM.createRoot(root).render(<BookingApp />)
}
