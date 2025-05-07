# frozen_string_literal: true
require_relative 'piece'

class King < Piece
  def symbol
    color == :white ? '♔' : '♚'
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
  
    direction.each do |dr, dc| # Loop through all 8 possible king directions
      new_row = @row + dr       # Step 1: calculate the new position
      new_col = @col + dc
  
      if on_board?(new_row, new_col) # Step 2: make sure we stay on the board
        target = board[new_row][new_col] # Step 3: look at what's on the target square
  
        # Step 4: if the square is empty OR has an enemy piece, it's a legal move
        if target.nil? || target.color != self.color
          moves << [new_row, new_col]   # Step 5: add to valid moves
        end
      end
    end
  
    moves # return the list of legal king moves
  end
end
