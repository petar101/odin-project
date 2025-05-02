class Game 
  attr_reader :board, :player_x, :player_o
  
  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }  # 6 rows, 7 columns, initially empty
    @player_x = 'X'
    @player_o = 'O'
    @current_player = @player_x
  end

  def display_board
    puts "\n"
    @board.each do |row|
      print "| "
      row.each do |cell|
        print "#{cell} | "
      end
      puts "\n" + "-" * 29
    end
    puts "  1   2   3   4   5   6   7  "  # Column numbers for players
  end

  def put_value(column, token)
    # Loop from bottom (row 5) to top (row 0)
    5.downto(0) do |row|
      if @board[row][column] == ' '
        @board[row][column] = token
        return true
      end
    end
    puts "Column is full"
    false  # Column is full
  end

  def switch_player
    @current_player = @current_player == @player_x ? @player_o : @player_x
  end

  def check_victory
    rows = @board.length
    cols = @board[0].length

    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next if cell == ' '

        token = cell

        # Check horizontal (right)
        if col_index <= cols - 4 &&
           (0..3).all? { |i| @board[row_index][col_index + i] == token }
          return true
        end

        # Check vertical (down)
        if row_index <= rows - 4 &&
           (0..3).all? { |i| @board[row_index + i][col_index] == token }
          return true
        end

        # Check diagonal (down-right)
        if row_index <= rows - 4 && col_index <= cols - 4 &&
           (0..3).all? { |i| @board[row_index + i][col_index + i] == token }
          return true
        end

        # Check diagonal (up-right)
        if row_index >= 3 && col_index <= cols - 4 &&
           (0..3).all? { |i| @board[row_index - i][col_index + i] == token }
          return true
        end
      end
    end

    false
  end

  def start 
    puts "Welcome to Connect 4! Player 1 is 'X', Player 2 is 'O'"
    
    loop do
      display_board
      puts "\nPlayer #{@current_player}'s turn"
      print "Choose a column (1-7): "
      column = gets.chomp.to_i - 1  # Convert to 0-based index
      
      if column.between?(0, 6)
        if put_value(column, @current_player)
          if check_victory
            display_board
            puts "\nCongratulations! Player #{@current_player} won!"
            break
          end
          switch_player
        end
      else
        puts "Invalid column! Please choose between 1 and 7"
      end
    end
  end
end