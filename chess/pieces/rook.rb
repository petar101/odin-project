# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def symbol
    color == :white ? '♖' : '♜'
  end

  def direction
    [
      [-1, 0], # up
      [0, -1], # left
      [0, 1],  # right
      [1, 0]   # down
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
          moves << [current_row, current_col] if target.color != color
          break
        end
      end
    end

    moves
  end
end
