# app/controllers/sets_controller.rb
class SetsController < ApplicationController
  def index
    @sets = Set.all
  end

  def show
    @set = Set.find(params[:id])
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_cards_by_set(@set.api_id)

    if response.success?
      @cards = response['data']
    else
      @cards = []
      flash[:alert] = "Failed to fetch cards from the Pokemon TCG API."
    end
  end

  def populate
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_sets

    if response.success?
      response['data'].each do |set_data|
        Set.find_or_create_by(api_id: set_data['id']) do |set|
          set.name = set_data['name']
        end
      end
      flash[:notice] = "Sets successfully populated."
    else
      flash[:alert] = "Failed to fetch sets from the Pokemon TCG API."
    end

    redirect_to sets_path
  end
end
