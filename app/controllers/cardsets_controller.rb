# app/controllers/card_sets_controller.rb
class CardSetsController < ApplicationController
  def index
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_sets

    if response.success?
      @card_sets = response['data']
    else
      @card_sets = []
      flash[:alert] = "Failed to fetch the sets from the Pokemon TCG API."
    end
  end

  def show
    api = PokemonTcgApi.new(ENV['POKEMON_TCG_API_KEY'])
    response = api.fetch_set(params[:id])

    if response.success?
      @card_set = response['data']
    else
      @card_set = nil
      flash[:alert] = "Failed to fetch the set from the Pokemon TCG API."
      redirect_to card_sets_path
    end
  end

  def new
    @card_set = CardSet.new
  end

  def create
    @card_set = CardSet.new(card_set_params)
    if @card_set.save
      redirect_to @card_set, notice: 'CardSet was successfully created.'
    else
      render :new
    end
  end

  def edit
    @card_set = CardSet.find(params[:id])
  end

  def update
    @card_set = CardSet.find(params[:id])
    if @card_set.update(card_set_params)
      redirect_to @card_set, notice: 'CardSet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card_set = CardSet.find(params[:id])
    @card_set.destroy
    redirect_to card_sets_url, notice: 'CardSet was successfully destroyed.'
  end

  private

  def card_set_params
    params.require(:card_set).permit(:set_name, :set_series)
  end
end
