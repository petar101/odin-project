# frozen_string_literal: true

require_relative 'board' # Load the Board class from board.rb
require_relative 'computer'

class Mastermind
  attr_reader :board, :victory, :guess

  def initialize
    @board = Board.new
    @board.new_board
    @victory = false
    @guess = 13
  end

  # Process the player's input (expects comma-separated letters like "r,b,g,y")
  def get_player_input
    mapping = {
      'r' => 'Red',
      'b' => 'Blue',
      'g' => 'Green',
      'y' => 'Yellow'
    }

    loop do
      input = gets.chomp
      # Convert input into an array of full color names.
      colours = input.split(',').map { |letter| mapping[letter.strip.downcase] }
      # If any letter is invalid (mapping returns nil), colours will contain nil.
      return colours unless colours.any?(&:nil?)

      puts 'Wrong input, try again.'
    end
  end

  def check_victory(guess, target)
    correct_positions = 0
    target.each_with_index do |colour, index|
      correct_positions += 1 if colour.to_s.downcase == guess[index].downcase
    end

    if correct_positions == 4
      @victory = true
      victory_message
      exit
    else
      @guess -= 1
      puts "Wrong! #{@guess} guesses left"
    end
  end

  def guess_max
    return unless @guess.zero? && @victory == false

    puts 'Too many guesses, You LOSE !!!'
    exit
  end

  def clue(game_board, input)
    correct_positions = 0
    game_board.each_with_index do |colour, index|
      correct_positions += 1 if colour.to_s.downcase == input[index].downcase
    end
    puts "There are #{correct_positions} correct positions in your guess."
    puts ''
    @computer.receive_feedback(correct_positions) if is_a?(CreateGame)
  end

  def choose
    choice = gets.chomp

    case choice
    when '1'
      GuessGame.new.play
    when '2'
      CreateGame.new.play
    else
      puts "Error: Please enter either '1' or '2'"
      choose
    end
  end

  def play
    puts 'Welcome to Mastermind!'
    puts 'The options are: Red = r, Blue = b, Green = g, Yellow = y'
    puts "Type '1' to guess the board. Type '2' to create the board."
    choose
  end

  private

  def victory_message
    if is_a?(GuessGame)
      puts 'Congrats, you won!'
    elsif is_a?(CreateGame)
      puts 'The computer won!'
    end
  end
end

# Inherit from Mastermind to get access to all shared methods
class GuessGame < Mastermind
  def play
    puts 'Guess the contents of the board. Eg: r,b,g,y'
    @board.new_board

    until @victory == true || @guess.zero?
      input = get_player_input
      check_victory(input, @board.game_board)
      guess_max
      clue(@board.game_board, input) unless @victory
    end
  end
end

# Inherit from Mastermind to get access to all shared methods
class CreateGame < Mastermind
  def initialize
    super # Keep the parent class initialization
    @computer = Computer.new # Add the computer
  end

  def play
    puts 'Create the contents of the board. Eg: r,b,g,y'
    player_board = get_player_input
    @board.game_board = player_board

    until @victory == true || @guess.zero?
      computer_guess = @computer.make_guess
      check_victory(computer_guess, @board.game_board)
      guess_max
      clue(@board.game_board, computer_guess) unless @victory
    end
  end
end
