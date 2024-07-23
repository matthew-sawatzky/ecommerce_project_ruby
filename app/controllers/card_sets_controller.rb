# app/controllers/card_sets_controller.rb
class CardSetsController < ApplicationController
  def index
    @card_sets = CardSet.all

    if @card_sets.empty?
      flash[:alert] = "No card sets available. Please run the seed script to populate the card sets."
    end
  end

  def show
    @card_set = CardSet.find(params[:id])
    @cards = @card_set.cards

    if @card_set.nil?
      flash[:alert] = "Failed to fetch the set."
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

  def select
    selected_id = params[:id]
    redirect_to card_set_path(selected_id)  # Redirect to the show page of the selected card set
  end

  private

  def card_set_params
    params.require(:card_set).permit(:name, :series)
  end
end
