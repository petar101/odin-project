# frozen_string_literal: true

def stock_picker(stocks)
  best_days = [0, 0]
  best_profit = 0

  # Loop through each day as a potential buy day.
  stocks.each_with_index do |buy_price, buy_index|
    # For each buy day, look at the days after it as potential sell days.
    stocks[(buy_index + 1)..].each_with_index do |sell_price, relative_index|
      # Calculate the actual index for the sell day.
      sell_index = buy_index + relative_index + 1

      # Calculate profit for this buy-sell pair.
      profit = sell_price - buy_price

      # If this profit is better than the current best, update best_profit and best_days.
      if profit > best_profit
        best_profit = profit
        best_days = [buy_index, sell_index]
      end
    end
  end

  best_days
end

# Ask the user to input stock prices separated by spaces.
puts 'Enter stock prices for every day (separated by spaces):'
input = gets.chomp
stocks = input.split.map(&:to_f)

buy_day, sell_day = stock_picker(stocks)

# When displaying, add 1 to each day so it appears as day 1, 2, 3, etc.
puts "The best time to buy is on day #{buy_day + 1} at a price of $#{stocks[buy_day]}."
puts "The best time to sell is on day #{sell_day + 1} at a price of $#{stocks[sell_day]}."
