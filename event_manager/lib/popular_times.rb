# frozen_string_literal: true

require 'date'
require 'csv'

# Define the method first
def popular_times(contents)
  registration_hours = []
  registration_days = [] # Changed name for clarity

  contents.each do |row|
    time = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
    registration_hours << time.hour
    registration_days << time.wday # Use wday directly from DateTime object
  end

  # Get most common hour
  most_common_hour = registration_hours.tally.max_by { |_k, v| v }

  # Get most common day
  most_common_day = registration_days.tally.max_by { |_k, v| v }

  # Return both values in a hash
  {
    hour: most_common_hour[0],
    day: convert_day_number(most_common_day[0]) # Add helper method to convert number to day name
  }
end

# Helper method to convert day number to name
def convert_day_number(day_num)
  days = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  days[day_num]
end

# Now you can use the method
@contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

popular_times_data = popular_times(@contents)
puts "Most common hour: #{popular_times_data[:hour]}:00"
puts "Most common day: #{popular_times_data[:day]}"
