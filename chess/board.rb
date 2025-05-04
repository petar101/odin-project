class Board
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def display
    puts "  a b c d e f g h"
    @board.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |piece|
        print piece ? piece.symbol : "."
        print " "
      end
      puts "#{8 - i}"
    end
    puts "  a b c d e f g h"
  end
end

