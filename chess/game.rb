# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces/pawn'
require_relative 'player'

class Game
  attr_reader :player1, :player2, :current_player

  def initialize
    @board = Board.new
    initialize_pieces
    @player1 = Player.new(:white, "Player 1")
    @player2 = Player.new(:black, "Player 2")
    @current_player = @player1
  end

  def initialize_pieces
    # White pawns on row 6 (rank 2)
    8.times do |col|
      @board.grid[6][col] = Pawn.new(6, col, :white)
    end

    # Black pawns on row 1 (rank 7)
    8.times do |col|
      @board.grid[1][col] = Pawn.new(1, col, :black)
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def victory?
    false
  end

  def algebraic_to_coords(pos)
    col = pos[0].downcase.ord - 'a'.ord  # 'a' -> 0, 'b' -> 1, etc.
    row = 8 - pos[1].to_i                # '2' -> 6, '7' -> 1, etc.
    [row, col]
  end

  def parse_input
    puts "#{@current_player.name} (#{@current_player.color}), enter your move (e.g. d2 d3):"
    input = gets.chomp
    from, to = input.split
    return :invalid unless from && to
  
    from_row, from_col = algebraic_to_coords(from)
    to_row, to_col     = algebraic_to_coords(to)
  
    piece = @board.grid[from_row][from_col]
  
    if piece.nil?
      puts "No piece at #{from}."
      return :invalid
    end
  
    if piece.color != @current_player.color
      puts "That piece doesn't belong to you."
      return :invalid
    end
  
    unless piece.move(@board.grid).include?([to_row, to_col])
      puts "Invalid move for that piece."
      return :invalid
    end
  
    # Move is valid — apply it
    @board.grid[to_row][to_col] = piece
    @board.grid[from_row][from_col] = nil
    piece.row, piece.col = to_row, to_col
    :success
  end
  
  def play
    puts 'Welcome to Chess!'
    puts "Here's the initial board setup:"
    @board.display
    
    until victory?
      puts "\nCurrent board:"
      @board.display
  
      result = :invalid
      until result == :success
        result = parse_input
      end
      switch_player
    end
  end
end

# Start the game
game = Game.new
game.play
