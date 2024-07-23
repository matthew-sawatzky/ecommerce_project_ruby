# lib/tasks/cards.rake

namespace :cards do
  desc "Set random prices for all cards"
  task set_random_prices: :environment do
    Card.find_each do |card|
      # Generate a random price between 1 and 100, rounded to two decimal points
      random_price = (rand * 100).round(2)
      card.update(price: random_price)
    end
    puts "Random prices have been set for all cards."
  end
end
