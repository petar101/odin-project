# frozen_string_literal: true

class Player
  attr_reader :color, :name

  def initialize(color, name = nil)
    @color = color
    @name = name || (color == :white ? 'White' : 'Black')
  end
end
