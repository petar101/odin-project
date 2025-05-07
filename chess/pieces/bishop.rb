# frozen_string_literal: true
require_relative 'piece'

class Bishop < Piece
  def symbol
    color == :white ? '♗' : '♝'
  end

  def direction
    [
      [-1, -1], # up-left
      [-1, 1],  # up-right
      [ 1, -1], # down-left
      [ 1, 1]   # down-right
    ]
  end

  def move(board)
    moves = []
  
    direction.each do |dr, dc|
      current_row = @row
      current_col = @col
      
      loop do
        current_row += dr
        current_col += dc
        
        break unless on_board?(current_row, current_col)
        
        target = board[current_row][current_col]
        if target.nil?
          moves << [current_row, current_col]
        else
          moves << [current_row, current_col] if target.color != self.color
          break
        end
      end
    end
  
    moves
  end
end
