# frozen_string_literal: true
require_relative 'piece'

class Pawn < Piece
  def symbol
    color == :white ? '♟' : '♙'
  end

  def direction
    color == :white ? -1 : 1
  end

  def move(board)
    moves = []

    # One step forward
    new_row = row + direction
    moves << [new_row, col] if on_board?(new_row, col) && board[new_row][col].nil?

    # Diagonal captures (left and right)
    [-1, 1].each do |dc|
      new_col = col + dc
      next unless on_board?(new_row, new_col)

      target = board[new_row][new_col]
      moves << [new_row, new_col] if target && target.color != color
    end

    moves
  end
end
