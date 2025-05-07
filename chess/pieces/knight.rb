# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def symbol
    color == :white ? '♘' : '♞'
  end

  def direction
    [
      [-2, -1], # up-left
      [-2, 1],  # up-right
      [-1, -2], # left-up
      [-1, 2],  # right-up
      [1, -2],  # left-down
      [1, 2],   # right-down
      [2, -1],  # down-left
      [2, 1]    # down-right
    ]
  end

  def move(board)
    moves = []

    direction.each do |dr, dc|
      new_row = @row + dr
      new_col = @col + dc

      next unless on_board?(new_row, new_col)

      target = board[new_row][new_col]
      moves << [new_row, new_col] if target.nil? || target.color != color
    end

    moves
  end
end
