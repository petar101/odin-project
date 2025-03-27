# frozen_string_literal: true

# Define the dictionary of words
dictionary = %w[hello world ruby programming code function
                variable array hash loop condition class
                module method object string integer float
                boolean nil]

# This method creates a hash (named 'results') where keys are words that match
# the substring and values are the count of occurrences within each word.
def find_matches(input, dictionary)
  results = {} # <-- Here we create an empty hash to store the results.
  dictionary.each do |word|
    # Count occurrences of the substring using scan and count
    count = word.scan(input).count
    # If there's at least one occurrence, add the word and count to the hash
    results[word] = count if count.positive?
  end
  results
end

# Prompt the user for a substring to search for
puts 'Enter a substring to search for:'
input = gets.chomp

# Get the hash of matches and occurrences
matches = find_matches(input, dictionary)

# Output the resulting hash
puts "Matches: #{matches}"
