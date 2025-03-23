# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class TicTacToe
  def initialize
    player1 = Player.new('Player 1', 'x')
    player2 = Player.new('Player 2', 'o')
    @board = Board.new
    @victory = false
    @game_started = false
    @current_player = player1
    @other_player = player2
  end

  def check_victory
    grid = @board.grid

    # Rows
    lines = (0..2).map do |row|
      [grid[row][0], grid[row][1], grid[row][2]]
    end

    # Columns
    (0..2).each do |col|
      lines << [grid[0][col], grid[1][col], grid[2][col]]
    end

    # Diagonals
    lines << [grid[0][0], grid[1][1], grid[2][2]]
    lines << [grid[0][2], grid[1][1], grid[2][0]]

    # Check each line for a win
    lines.each do |line|
      if line.all?('X')
        @victory = true
        return 'X'
      elsif line.all?('O')
        @victory = true
        return 'O'
      end
    end
    false
  end

  def switch_player
    return if @victory

    @current_player, @other_player = @other_player, @current_player
    puts "#{@current_player.mark}'s Turn:" # Assuming players have a 'mark' attribute.
  end

  def draw?
    @board.grid.flatten.none?(&:nil?)
  end

  def game
    puts 'Good Day, Player 1 and Player 2. Are you prepared for an epic game of TicTacToe?'
    puts "Type 'start' to begin the game ... "

    start = gets.chomp

    if start.downcase == 'start'
      @game_started = true
      @board.display_grid
    else
      puts "You spelled 'start' wrong, silly! Type 'ruby run.rb' to play"
      return
    end

    until @victory
      puts "Enter your move as 'row,col' (e.g., '1,3'):"
      puts "X's Turn:"
      input = gets.chomp
      row, col = input.split(',').map { |s| s.strip.to_i }

      row -= 1
      col -= 1

      # Validate the move (ensure it's within bounds and the cell is empty)
      next unless row.between?(0, 2) && col.between?(0, 2) && @board.grid[row][col].nil?

      # Place the current player's mark on the board.
      @board.grid[row][col] = @current_player.mark

      @board.display_grid

      # Check for a victory after the move.
      if check_victory
        puts "#{@current_player.mark} wins!!!"
        break
      elsif draw?
        puts 'its a draw'
        break
      end

      switch_player

      puts 'Invalid move, please try again.'
    end
  end
end
