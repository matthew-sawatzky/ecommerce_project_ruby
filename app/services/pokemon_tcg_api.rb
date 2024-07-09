class PokemonTcgApi
  include HTTParty
  base_uri 'https://api.pokemontcg.io/v2'

  def initialize(api_key)
    @headers = {
      "X-Api-Key" => api_key
    }
  end

  def fetch_cards(query = {})
    options = { headers: @headers, query: query }
    self.class.get('/cards', options)
  end

  def fetch_card(card_id)
    options = { headers: @headers }
    self.class.get("/cards/#{card_id}", options)
  end

  def fetch_sets
    options = { headers: @headers }
    self.class.get('/sets', options)
  end
end
