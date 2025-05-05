# frozen_string_literal: true

class Piece
  attr_accessor :row, :col, :color

  def initialize(row, col, color)
    @row = row
    @col = col
    @color = color
  end

  def moves
    []
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end
end
