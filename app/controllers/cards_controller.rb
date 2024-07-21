class CardsController < ApplicationController
  def index
    if params[:card_set_id].present?
      card_set = CardSet.find(params[:card_set_id])
      @cards = Kaminari.paginate_array(card_set.cards).page(params[:page]).per(20)
    else
      @cards = Kaminari.paginate_array(Card.all).page(params[:page]).per(20)
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def search
    @query = params[:query]
    @cards = if @query.present?
               Kaminari.paginate_array(Card.where('name LIKE ?', "%#{@query}%")).page(params[:page]).per(20)
             else
               Kaminari.paginate_array(Card.all).page(params[:page]).per(20)
             end
    render :index
  end
end
