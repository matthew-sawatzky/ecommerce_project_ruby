class CardsController < ApplicationController
  def index
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_cards

    if response.success?
      @cards = response['data']
    else
      @cards = []
      flash[:alert] = "Failed to fetch cards from the Pokemon TCG API."
    end
  end

  def show
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_card(params[:id])

    if response.success?
      @card = response['data']
    else
      @card = nil
      flash[:alert] = "Failed to fetch the card from the Pokemon TCG API."
    end
  end
end
