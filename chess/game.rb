  # encoding: utf-8

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

# Initilize player 1 and player 2 
# initalize pieces onto the board 
# set up input and switch for players
# validate input
# set rules for check and check_mate and stalemate
# 
#

# Start the game
game = Game.new
game.play
