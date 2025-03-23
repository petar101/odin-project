# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'tictactoe'

if __FILE__ == $PROGRAM_NAME
  game_instance = TicTacToe.new
  game_instance.game
end
