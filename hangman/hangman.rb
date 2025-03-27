# frozen_string_literal: true

require 'yaml'
require_relative 'save_game'

class Game
  attr_accessor :wrong_guess, :wrong_letters, :answer, :secret, :victory

  def initialize
    @wrong_letters = []
    @victory = false
    @wrong_guess = 0
    @answer, @secret = secret_word
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
    print 'Enter a letter or word (type "save" to save game): '
    guess = gets.chomp.downcase

    if guess == 'save'
      Update.new.save_game(self)
      exit
    end

    unless guess.match?(/^[a-z]+$/)
      puts 'Error: Please enter only letters (a-z)'
      return make_guess
    end

    if guess.length > 1
      handle_word_guess(guess)
    else
      handle_letter_guess(guess)
    end

    check_victory
    display_game_state
  end

  def handle_word_guess(guess)
    if guess == @answer.join
      @secret = @answer.dup
      @victory = true
    else
      @wrong_guess += 1
      puts 'Wrong word guess!'
    end
  end

  def handle_letter_guess(guess)
    found_letter = false
    @answer.each_with_index do |letter, index|
      if letter == guess
        @secret[index] = guess
        found_letter = true
      end
    end

    return if found_letter

    @wrong_letters << guess unless @wrong_letters.include?(guess)
    @wrong_guess += 1
  end

  def display_menu
    puts "\nWelcome to Hangman!"
    puts '1. New Game'
    puts '2. Load Saved Game'
    print "\nSelect an option (1-2): "

    choice = gets.chomp

    case choice
    when '1'
      run
    when '2'
      load_saved_game
    else
      puts 'Invalid option. Please try again.'
      display_menu
    end
  end

  def load_saved_game
    if File.exist?('save.yaml')
      saved_game = Update.new.load_game
      if saved_game
        puts 'Game loaded successfully!'
        load_game_state(saved_game)
        run
      end
    else
      puts 'No saved game found!'
      display_menu
    end
  end

  def load_game_state(saved_game)
    @wrong_letters = saved_game.wrong_letters
    @victory = saved_game.victory
    @wrong_guess = saved_game.wrong_guess
    @answer = saved_game.answer
    @secret = saved_game.secret
  end

  def run
    display_game_state
    make_guess until @victory || @wrong_guess >= 12
    display_end_game_message
  end

  def display_end_game_message
    if @victory
      puts "Congratulations! You won! The word was: #{@answer.join}"
    else
      puts "Game Over! The word was: #{@answer.join}"
    end
  end

  def display_game_state
    puts "\nWord: #{@secret.join(' ')}"
    puts "Wrong guesses (#{@wrong_guess}/12): #{@wrong_letters.join(', ')}"
  end
end

# Create and start a new game
game = Game.new
game.display_menu
