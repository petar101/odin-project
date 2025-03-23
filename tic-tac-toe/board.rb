# frozen_string_literal: true

class Board
  def grid
    @grid ||= Array.new(3) { Array.new(3) }
  end

  def display_grid
    grid.each do |row|
      row_display = row.map { |cell| cell.nil? ? '_' : cell }
      puts row_display.join(' | ')
      puts ' '
    end
  end

  def reset_board
    return unless victory == true

    puts 'type reset to start again'
    input = gets.chomp

    if input.downcase == 'reset'
      @grid ||= Array.new(3) { Array.new(3) }
    else
      puts "don't know what your talking about mate"
    end
  end
end
