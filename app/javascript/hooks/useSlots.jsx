import { useEffect, useState } from 'react'
import { createConsumer } from '@rails/actioncable'
import axios from 'axios'
import { format } from 'date-fns'
import { isNil } from 'lodash'

export const TIMEZONE = Intl.DateTimeFormat().resolvedOptions().timeZone
const consumer = createConsumer()

export const useSlots = (date, duration) => {
  const [availableSlots, setAvailableSlots] = useState({})
  const [errorMessage, setErrorMessage] = useState('')

  useEffect(() => {
    if(isNil(date) || isNil(duration)) return

    axios.get('/api/availability', {
      params: { date: format(date, 'dd-MM-yyyy'), duration: duration, timezone: TIMEZONE }
    })
    .then(({ data }) => {
      setAvailableSlots(data)
    })
    .catch((error) => {
      setErrorMessage(`An error occurred: ${error?.response?.errors?.join(',') ?? 'System error'}`)
    })
  }, [date, duration])

  useEffect(() => {
    const channel = consumer.subscriptions.create({
      channel: 'BookingAvailabilityChannel',
      month: format(date, "MM-yyyy")
    }, {
      received: (data) => {
        const { slots } = data

      setAvailableSlots(slots)
      }
    })

    return () => { channel.unsubscribe() }
  }, [date, duration])

  return { availableSlots, errorMessage }
}
