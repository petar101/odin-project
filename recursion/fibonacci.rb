# frozen_string_literal: true

def fibs(n)
  return [] if n.zero?
  return [0] if n == 1
  return [0, 1] if n == 2

  array = [0, 1]
  while array.length < n
    new_number = array[-1] + array[-2]
    array << new_number
  end
  array
end

def fib_rec(n)
  return [] if n.zero?
  return [0] if n == 1
  return [0, 1] if n == 2

  sequence = fib_rec(n - 1)

  sequence << sequence[-1] + sequence[-2]

  sequence
end

# Get input from user
puts 'How many Fibonacci numbers do you want?'
print '> '
user_input = gets.chomp.to_i

# Run and display result
result = fib_rec(user_input)
puts "Here are the first #{user_input} Fibonacci numbers:"
puts result.inspect
