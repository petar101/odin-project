require 'set'  

class KnightTravails
  def initialize(start_position, end_position)
    @start_position = start_position
    @end_position = end_position
  end

  def knight_moves
    [
      [2, 1], [1, 2], [-1, 2], [-2, 1],
      [-2, -1], [-1, -2], [1, -2], [2, -1]
    ]
  end

  def valid_position?(position)
    x, y = position
    x.between?(0,7) && y.between?(0,7)
  end

  def search_end
    queue = []
    visited = Set.new

    queue << [@start_position, [@start_position]]
    visited.add(@start_position)

    until queue.empty?
      current_position, path_so_far = queue.shift

      return path_so_far if current_position == @end_position

      knight_moves.each do |dx, dy|
        new_x = current_position[0] + dx
        new_y = current_position[1] + dy
        new_position = [new_x, new_y]

        if valid_position?(new_position) && !visited.include?(new_position)
          visited.add(new_position)
          queue << [new_position, path_so_far + [new_position]]
        end
      end
    end

    nil  # If no path found (shouldn't happen on an 8x8 board)
  end

  def display_path
    path = search_end
    if path
      puts "\nYou made it in #{path.length - 1} moves! Here's your path:"
      path.each { |position| puts position.inspect }
    else
      puts "No path found!"
    end
  end
end

def get_position(prompt)
  loop do
    print prompt
    input = gets.chomp
    begin
      position = input.split(',').map(&:to_i)
      if position.length == 2 && position.all? { |n| n.between?(0, 7) }
        return position
      else
        puts "Please enter valid coordinates between 0 and 7 (e.g., '0,0')"
      end
    rescue
      puts "Please enter coordinates in the format 'x,y' (e.g., '0,0')"
    end
  end
end

# Console interface
puts "Welcome to Knight's Travails!"
puts "Enter coordinates between 0 and 7 (e.g., '0,0' for the bottom-left corner)"
puts "The chessboard is 8x8, with coordinates ranging from [0,0] to [7,7]"

start = get_position("Enter starting position (x,y): ")
finish = get_position("Enter ending position (x,y): ")

knight = KnightTravails.new(start, finish)
knight.display_path