def caesar(input, left_shift)
  letters = ('a'..'z').to_a + ('A'..'Z').to_a #turning letters to an array
  transform = input.chars.map do |char| #turning input in a array and iterating through each one 
    if letters.include?(char) # Only shift letters
      base = char.match?(/[A-Z]/) ? 'A' : 'a' # Determine uppercase or lowercase base
      (((char.ord - base.ord + left_shift) % 26) + base.ord).chr # Shift the letter
    else
      char # Keep non-letters unchanged
    end
  end
  transform.join
end

puts "welcome to the cipher hub !!!!"

puts "what would you like the cipher?"
input = gets.chomp

puts "how many shifts would you like to do"
left_shift = gets.chomp.to_i

puts "your cipher message is #{caesar(input, left_shift)}"

