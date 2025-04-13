require_relative 'hash_map'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "\nHash Map Statistics:"
puts "Initial length: #{test.length}"        # Should be 12
puts "Initial capacity: #{test.capacity}"    # Should match your initial size
puts "Load factor: #{test.load_factor}"      # Shows the load factor

puts "\nBucket Contents:"
test.instance_variable_get(:@buckets).each_with_index do |bucket, index|
  if bucket
    puts "\nBucket #{index}:"
    current = bucket
    while current
      puts "  Key: #{current.key}, Value: #{current.value}"
      current = current.next_node
    end
  else
    puts "\nBucket #{index}: Empty"
  end
end

puts "\nAll Keys: #{test.keys}"
puts "All Values: #{test.values}"
puts "All Entries: #{test.entries}"