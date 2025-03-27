# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require_relative 'letter_generator'
require 'date'
require_relative 'popular_times'

# This method cleans up zipcode data to ensure it's 5 digits
def clean_zipcode(zipcode)
  # Convert to string, pad with zeros if needed, and take first 5 digits
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone)
  # Remove any non-digit characters and convert to string
  phone = phone.to_s.gsub(/\D/, '')

  case phone.length
  when 10
    phone # Good number, return as is
  when 11
    phone[0] == '1' ? phone[1..] : 'Bad number: 11 digits not starting with 1'
  else
    'Bad number: incorrect number of digits'
  end
end

# This method takes a zipcode and returns the legislators for that area
def legislators_by_zipcode(zip)
  # Create a new instance of Google's Civic Info service
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(', ')
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, personal_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts personal_letter
  end
end

# Let user know program is starting
puts 'EventManager initialized.'

# Create letter generator instance
letter_generator = LetterGenerator.new('form_letter.erb')

@contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

puts "Most popular registration hour: #{@popular_times}:00"
# Process each row in the CSV file
@contents.each do |row|
  # Get the ID and name from the row
  id = row[0] # Get the actual ID from the row
  name = row[:first_name]
  phone = clean_phone_number(row[:homephone])
  puts "#{name} #{phone}"

  # Get and clean the zipcode from the row
  zipcode = clean_zipcode(row[:zipcode])

  # Look up legislators for this zipcode
  legislators = legislators_by_zipcode(zipcode)

  # Generate the personalized letter

  personal_letter = letter_generator.generate_letter(name, legislators)

  save_thank_you_letter(id, personal_letter)
end
