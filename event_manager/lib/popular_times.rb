require 'date'
require 'csv'

# Define the method first
def popular_times(contents)
  registration_hours = []
  
  contents.each do |row|
    time = DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M")
    registration_hours << time.hour
  end

  most_common_hour = registration_hours.tally.max_by { |_k, v| v }
  most_common_hour[0]  # Return just the hour
end

# Now you can use the method
@contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

@popular_times = popular_times(@contents)  # Call the method we defined
puts "Most common hour: #{@popular_times}:00"


