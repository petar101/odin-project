# frozen_string_literal: true
require_relative 'piece'

class King < Piece
  def symbol
    color == :white ? '♚' : '♔'
  end

  def direction
    [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]
  end

  def move(board)
    moves = []

    direction.each do |dr, dc| 
      new_row = direction + @row 
      new_col = direction + @col

      if on_board?(new_row, new_col)
        # same colour isn't on new_row new_col 
        # then move 
        #
      end
    end

  
    
    moves
  end
end
