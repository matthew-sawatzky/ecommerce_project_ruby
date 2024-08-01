require "net/http"
require "uri"
require "stringio"

def download_image(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  if response.is_a?(Net::HTTPSuccess)
    StringIO.new(response.body)
  else
    Rails.logger.error "Failed to download image from #{url}"
    nil
  end
end

api = PokemonTcgApi.new(ENV["POKEMON_TCG_API_KEY"])
response = api.fetch_sets

if response.success?
  all_card_sets = response["data"]

  # Create Card Sets first
  all_card_sets.each do |set_data|
    CardSet.find_or_create_by(name: set_data["name"], series: set_data["series"])
    set_id = set_data["id"]
    card_response = api.fetch_cards_by_set(set_id)

    next unless card_response.success?

    cards = card_response["data"]

    cards.each do |card_data|
      card_set = CardSet.find_by(name: set_data["name"])

      card = Card.create(
        name:      card_data["name"],
        supertype: card_data["supertype"],
        subtype:   card_data["subtypes"].join(", "), # assuming subtypes is an array
        rarity:    card_data["rarity"],
        card_set:  card_set
      )

      # Attach image if available
      next unless card_data["images"] && card_data["images"]["large"]

      image_url = card_data["images"]["large"]
      downloaded_image = download_image(image_url)
      if downloaded_image
        card.image.attach(io: downloaded_image, filename: "#{card_data['name']}.jpg")
      end
    end
  end
else
  Rails.logger.info "Failed to fetch the sets from the Pokemon TCG API."
end

# Seed admin user
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end

Province.create!([
  { province_name: "Alberta", provincial_tax: 0, federal_tax: 5, tax_type: "gst" },
  { province_name: "British Columbia", provincial_tax: 7, federal_tax: 5, tax_type: "pst" },
  { province_name: "Manitoba", provincial_tax: 7, federal_tax: 5, tax_type: "pst" },
  { province_name: "New Brunswick", provincial_tax: 10, federal_tax: 5, tax_type: "hst" },
  { province_name: "Newfoundland and Labrador", provincial_tax: 10, federal_tax: 5, tax_type: "hst" },
  { province_name: "Northwest Territories", provincial_tax: 0, federal_tax: 5, tax_type: "gst" },
  { province_name: "Nova Scotia", provincial_tax: 10, federal_tax: 5, tax_type: "hst" },
  { province_name: "Nunavut", provincial_tax: 0, federal_tax: 5, tax_type: "gst" },
  { province_name: "Ontario", provincial_tax: 8, federal_tax: 5, tax_type: "hst" },
  { province_name: "Prince Edward Island", provincial_tax: 10, federal_tax: 5, tax_type: "hst" },
  { province_name: "Quebec", provincial_tax: 9.975, federal_tax: 5, tax_type: "qst" },
  { province_name: "Saskatchewan", provincial_tax: 6, federal_tax: 5, tax_type: "pst" },
  { province_name: "Yukon", provincial_tax: 0, federal_tax: 5, tax_type: "gst" }
])
