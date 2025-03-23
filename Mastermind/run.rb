# frozen_string_literal: true

require_relative 'board' # Load the Board class from board.rb
require_relative 'game'
require_relative 'computer' # Load the Mastermind class from game.rb

game_guess = Mastermind.new
game_guess.play
