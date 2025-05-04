require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to Chess!"
    puts "Here's the initial board setup:"
    @board.display
  end
end

# Start the game
game = Game.new
game.play
