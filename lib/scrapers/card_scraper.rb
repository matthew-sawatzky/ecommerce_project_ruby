# lib/scrapers/card_scraper.rb

require 'nokogiri'
require 'httparty'
require 'csv'

class CardScraper
  def perform
    # URL of the website to scrape
    url = 'https://example.com/cards'

    # Send a GET request to the website
    response = HTTParty.get(url)

    # Parse the HTML content
    doc = Nokogiri::HTML(response.body)

    # Initialize an array to store the scraped data
    cards = []

    # Find and extract the data
    doc.css('.card').each do |card_div|
      name = card_div.at_css('h2')&.text
      image_url = card_div.at_css('img')['src'] rescue nil
      price = card_div.at_css('.price')&.text

      # Append the data to the list
      cards << {
        'name' => name,
        'image_url' => image_url,
        'price' => price
      }
    end

    # Print the scraped data to the console
    cards.each do |card|
      puts "Name: #{card['name']}"
      puts "Image URL: #{card['image_url']}"
      puts "Price: #{card['price']}"
      puts '-' * 40
    end

    # Save the scraped data to a CSV file
    CSV.open('cards.csv', 'w') do |csv|
      csv << ['Name', 'Image URL', 'Price'] # CSV header
      cards.each do |card|
        csv << [card['name'], card['image_url'], card['price']]
      end
    end

    puts "Scraping completed and data saved to cards.csv"
  end
end
