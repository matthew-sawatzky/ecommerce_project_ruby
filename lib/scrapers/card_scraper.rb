# lib/scrapers/card_scraper.rb

require "nokogiri"
require "httparty"
require "csv"

class CardScraper
  def perform
    url = "https://example.com/cards"
    response = HTTParty.get(url)
    doc = Nokogiri::HTML(response.body)
    cards = []

    doc.css(".card").each do |card_div|
      name = card_div.at_css("h2")&.text
      image_url = card_div.at_css("img")["src"] rescue nil
      price = card_div.at_css(".price")&.text
      cards << {
        "name" => name,
        "image_url" => image_url,
        "price" => price
      }
    end

    cards.each do |card|
      puts "Name: #{card['name']}"
      puts "Image URL: #{card['image_url']}"
      puts "Price: #{card['price']}"
      puts "-" * 40
    end

    CSV.open("cards.csv", "w") do |csv|
      csv << ["Name", "Image URL", "Price"]
      cards.each do |card|
        csv << [card["name"], card["image_url"], card["price"]]
      end
    end
  end
end
