require 'csv'
require 'google/apis/civicinfo_v2'
require_relative 'letter_generator'


# This method cleans up zipcode data to ensure it's 5 digits
def clean_zipcode(zipcode)
  # Convert to string, pad with zeros if needed, and take first 5 digits
  zipcode.to_s.rjust(5, '0')[0..4]
end

# This method takes a zipcode and returns the legislators for that area
def legislators_by_zipcode(zip)
  # Create a new instance of Google's Civic Info service
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    # Make the API call to Google to get legislator info
    legislators = civic_info.representative_info_by_address(
      address: zip,                                    # Use the zipcode we received
      levels: 'country',                              # Only get national legislators
      roles: ['legislatorUpperBody', 'legislatorLowerBody']  # Get both Senators and Representatives
    )
    
    # Process the API response
    legislators = legislators.officials                # Get just the officials array
    legislator_names = legislators.map(&:name)        # Extract just their names
    legislator_names.join(", ")                       # Join names with commas between
  rescue
    # If anything goes wrong, return this message
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

# Let user know program is starting
puts 'EventManager initialized.'

# Create letter generator instance
letter_generator = LetterGenerator.new('form_letter.html.erb')


@contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

# Process each row in the CSV file
@contents.each do |row|
  # Get the first name from the row
  name = row[:first_name]
  
  # Get and clean the zipcode from the row
  zipcode = clean_zipcode(row[:zipcode])
  
  # Look up legislators for this zipcode
  legislators = legislators_by_zipcode(zipcode)
  
  # Print out the results
  puts "#{name} #{zipcode} #{legislators}"
  
  # Generate the letter
  personal_letter = letter_generator.generate_letter(name, legislators)
  puts personal_letter
end







