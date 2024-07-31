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
    cards <<
      {
        "name"     => name,
        "price"    => price,
        "quantity" => quantity
      }
  end


    cards.each do |card|
      Rails.logger.info "Name: #{card['name']}"
      Rails.logger.info "Image URL: #{card['image_url']}"
      Rails.logger.info "Price: #{card['price']}"
      Rails.logger.info "-" * 40
    end

    CSV.open("cards.csv", "w") do |csv|
      csv << ["Name", "Image URL", "Price"]
      cards.each do |card|
        csv << [card["name"], card["image_url"], card["price"]]
      end
    end
  end
end
