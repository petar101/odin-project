# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces/pawn'
require_relative 'player'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'check_rules'

class Game
  attr_reader :player1, :player2, :current_player

  include CheckRules

  def initialize
    @board = Board.new
    initialize_pieces
    @player1 = Player.new(:white, 'Player 1')
    @player2 = Player.new(:black, 'Player 2')
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

    @board.grid[7][4] = King.new(7, 4, :white) # e1
    @board.grid[0][4] = King.new(0, 4, :black) # e8

    @board.grid[7][3] = Queen.new(7, 3, :white) # d1
    @board.grid[0][3] = Queen.new(0, 3, :black) # d8

    # White rooks
    @board.grid[7][0] = Rook.new(7, 0, :white) # a1
    @board.grid[7][7] = Rook.new(7, 7, :white) # h1

    # Black rooks
    @board.grid[0][0] = Rook.new(0, 0, :black) # a8
    @board.grid[0][7] = Rook.new(0, 7, :black) # h8

    # White knights
    @board.grid[7][1] = Knight.new(7, 1, :white) # b1
    @board.grid[7][6] = Knight.new(7, 6, :white) # g1

    # Black knights
    @board.grid[0][1] = Knight.new(0, 1, :black) # b8
    @board.grid[0][6] = Knight.new(0, 6, :black) # g8

    # White bishops
    @board.grid[7][2] = Bishop.new(7, 2, :white) # c1
    @board.grid[7][5] = Bishop.new(7, 5, :white) # f1

    # Black bishops
    @board.grid[0][2] = Bishop.new(0, 2, :black) # c8
    @board.grid[0][5] = Bishop.new(0, 5, :black) # f8
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def handle_check
    if in_check?(@current_player.color)
      puts "#{@current_player.name} is in check!"
      if checkmate?(@current_player.color)
        puts "#{@current_player.name} is in checkmate! #{@current_player == @player1 ? 'Black' : 'White'} wins!"
        return true
      end
    end
    false
  end

  def victory?
    handle_check
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
      puts 'Invalid move for that piece.'
      return :invalid
    end

    # Move is valid — apply it
    @board.grid[to_row][to_col] = piece
    @board.grid[from_row][from_col] = nil
    piece.row = to_row
    piece.col = to_col
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
      result = parse_input until result == :success
      switch_player
    end
  end
end

# Start the game
game = Game.new
game.play
