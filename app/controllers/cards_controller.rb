class CardsController < ApplicationController
  def index
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    if params[:set_id].present?
      set = CardSet.find(params[:set_id])
      response = api.fetch_cards_by_set(set.api_id)
    else
      response = api.fetch_cards
    end

    if response.success?
      all_cards = response['data']
      @cards = Kaminari.paginate_array(all_cards).page(params[:page]).per(20)
    else
      @cards = Kaminari.paginate_array([]).page(params[:page]).per(20)
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

  def search
    @query = params[:query]
    @cards = if @query.present?
               Card.where('name LIKE ?', "%#{@query}%")
             else
               Card.all
             end
    render :index
  end
end
