class CardsController < ApplicationController
  def index
    if params[:card_set_id].present?
      card_set = CardSet.find(params[:card_set_id])
      @cards = Kaminari.paginate_array(card_set.cards).page(params[:page]).per(20)
    else
      @cards = Kaminari.paginate_array(Card.all).page(params[:page]).per(20)
    end

    respond_to do |format|
      format.html # renders the default HTML view (index.html.erb)
      format.json { render json: @cards.map { |card| card_with_image_url(card) } }
    end
  end

  def show
    @card = Card.find(params[:id])
    
    respond_to do |format|
      format.html # renders the default HTML view (show.html.erb)
      format.json { render json: card_with_image_url(@card) }
    end
  end

  def search
    @query = params[:query]
    @cards = if @query.present?
               Kaminari.paginate_array(Card.where('name LIKE ?', "%#{@query}%")).page(params[:page]).per(20)
             else
               Kaminari.paginate_array(Card.all).page(params[:page]).per(20)
             end

    respond_to do |format|
      format.html { render :index } # renders the default HTML view (index.html.erb)
      format.json { render json: @cards.map { |card| card_with_image_url(card) } }
    end
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      respond_to do |format|
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: card_with_image_url(@card), status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      respond_to do |format|
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render json: card_with_image_url(@card) }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def card_params
    params.require(:card).permit(:name, :description, :hp, :image)
  end

  def card_with_image_url(card)
    card.as_json.merge(image_url: url_for(card.image)) if card.image.attached?
  end
end
