# frozen_string_literal: true

require 'uri'
require 'open-uri'

url = 'https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt'

File.open('dictionary.txt', 'w') do |file|
  file.write(URI.open(url).read)
end

puts 'Dictionary downloaded and saved as dictionary.txt!'
