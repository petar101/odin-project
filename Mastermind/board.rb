# frozen_string_literal: true

class Board
  attr_accessor :game_board
  attr_reader :colours

  def initialize
    @game_board = Array.new(4)
    @colours = %i[red blue green yellow]
  end

  def new_board
    @game_board.map! { @colours.sample }
  end
end
