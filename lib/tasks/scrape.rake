# lib/tasks/scrape.rake

namespace :scrape do
  desc "Run the card scraper"
  task run_card_scraper: :environment do
    require_relative '../../lib/scrapers/card_scraper'
    # Call the scraper class or method here
    CardScraper.new.perform
  end
end
