# Changed dates to make them more relevant in the task.
BOOKINGS = [
  { id: "bd8fc476-ac50-3327-4ece-d73897796852", time_from: "2023-09-01T20:00:00.000Z", time_to: "2023-09-01T22:30:00.000Z" },
  { id: "8c73d0ca-d999-4081-1558-e5ee6a40fcc2", time_from: "2023-08-31T23:00:00.000Z", time_to: "2023-09-01T06:00:00.000Z" },
  { id: "086e3a96-2c74-3d2a-e839-ad10c82626d5", time_from: "2023-09-01T10:15:00.000Z", time_to: "2023-09-01T10:45:00.000Z" },
  { id: "9e323a9e-adf9-605f-9386-c939a9a6af3f", time_from: "2023-09-01T13:55:00.000Z", time_to: "2023-09-01T14:30:00.000Z" },
  { id: "0510de47-c86e-a64c-bb86-461c039b1012", time_from: "2023-09-02T10:00:00.000Z", time_to: "2023-09-02T20:00:00.000Z" },
  { id: "4b24e6ab-bdc6-6b2c-e405-a8e01f0fde84", time_from: "2023-09-01T09:00:00.000Z", time_to: "2023-09-01T10:00:00.000Z" },
  { id: "087ddebe-dd41-7e39-bda8-f617d8c4385d", time_from: "2023-09-01T11:30:00.000Z", time_to: "2023-09-01T13:00:00.000Z" },
  { id: "5117e557-8d86-4180-9326-1ce0cf733982", time_from: "2023-09-01T13:00:00.000Z", time_to: "2023-09-01T13:10:00.000Z" }
].freeze

Booking.insert_all(BOOKINGS)
