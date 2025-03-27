# frozen_string_literal: true

def bubble_sort(numbers)
  length = numbers.length

  # Outer loop: run the process for (length - 1) passes
  (length - 1).times do
    # Inner loop: iterate through indices 0 to length - 2
    # This way, numbers[i+1] will safely access the last element when i == length - 2.
    (0...(length - 1)).each do |i|
      if numbers[i] > numbers[i + 1]
        # Swap numbers[i] and numbers[i+1]
        numbers[i], numbers[i + 1] = numbers[i + 1], numbers[i]
      end
    end
  end

  numbers # Return the sorted array
end

# Input: a line of numbers separated by spaces
numbers = gets.chomp.split.map(&:to_i)

sorted_numbers = bubble_sort(numbers)
puts "Sorted: #{sorted_numbers.inspect}"

# Delete testing Git
