# frozen_string_literal: true

class Game
  def initialize
    @correct_letters = []
    @wrong_letters = []
    @victory = false
    @wrong_guess = 0
    @answer, @secret = secret_word # Store the word when game starts
  end

  def secret_word
    dictionary = File.readlines('dictionary.txt').select { |word| word.strip.length.between?(5, 12) }
    word = dictionary.sample.strip
    answer = word.chars
    secret = Array.new(answer.length, '_')
    [answer, secret]
  end

  def check_victory
    @victory = !@secret.include?('_')
  end

  def make_guess
    secret_word
    print 'Enter a letter or word: '
    guess = gets.chomp.downcase

    unless guess.match?(/^[a-z]+$/)
      puts "Error: Please enter only letters (a-z)"
      return make_guess  # Recursively ask for input again
    end

    if guess.length > 1
      # Handle word guess
      if guess == @answer.join
        @secret = @answer.dup
        @victory = true
      else
        @wrong_guess += 1
        puts "Wrong word guess!"
      end
    else
      # Handle single letter guess
      found_letter = false
      @answer.each_with_index do |letter, index|
        if letter == guess
          @secret[index] = guess
          found_letter = true
        end
      end

      unless found_letter
        @wrong_letters << guess unless @wrong_letters.include?(guess)
        @wrong_guess += 1
      end
    end

    check_victory 
    display_game_state # Add a method to show current state
  end

  def run
    puts 'Welcome to hangman, guess to win, you have 12 guesses'
    puts ''
    
    display_game_state
    
    make_guess until @victory || @wrong_guess >= 12

    if @victory
      puts "Congratulations! You won! The word was: #{@answer.join}"
    else
      puts "Game Over! The word was: #{@answer.join}"
    end
  end

  def display_game_state
    puts "\nWord: #{@secret.join(' ')}"
    puts "Wrong guesses (#{@wrong_guess}/12): #{@wrong_letters.join(', ')}"
    puts ''
  end
end


# Create and start a new game
game = Game.new
game.run



### got to add the option to guess an entire word 
## need to error check if its not a letter/word then respond error try again

## if saved_games = true, then ask if you want to load from saved games
# show options of how many saved games
