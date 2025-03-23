# frozen_string_literal: true

require_relative 'board' # Load the Board class from board.rb
require_relative 'game'

class Computer
  def initialize
    @colors = %w[Red Blue Green Yellow]
    @guess = nil
    @fake_answer = nil
    @correct_positions = 0
    @fake_correct_position = 0 # Generate all possible combinations (4^4 = 256 possibilities)
    @possible_answers = @colors.repeated_permutation(4).to_a
  end

  def receive_feedback(positions)
    @correct_positions = positions
  end

  def one_guess
    @guess = Array.new(4) { @colors.sample }
  end

  def filter_possible_answers
    @possible_answers.reject! do |possible_answer|
      # Compare this possible answer with our fake_answer
      matching_positions = 0
      possible_answer.each_with_index do |color, index|
        matching_positions += 1 if color == @fake_answer[index]
      end
      # Reject (remove) this possible answer if it has fewer matching positions
      # than what we know we should have (@fake_correct_position)
      matching_positions < @fake_correct_position
    end
  end

  def make_guess
    if @correct_positions.positive?
      @fake_answer = @guess.dup
      @fake_correct_position = @correct_positions
      filter_possible_answers
      # Make sure we have a valid guess, fallback to random if needed
      @guess = @possible_answers.empty? ? one_guess : @possible_answers.sample
    else
      one_guess
    end

    puts "Computer guesses: #{@guess.join(', ')}"
    @guess
  end
end
