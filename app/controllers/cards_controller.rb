class CardsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart
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

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Card.find(session[:cart])
  end

    def update_cart_item
    @item = Item.find(params[:id])
    
    if @item.update(item_params)
      redirect_to root_path, notice: 'Cart item updated successfully.'
    else
      redirect_to root_path, alert: 'Failed to update cart item.'
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
    card_set_id = params[:card_set_id]
    category_id = params[:category_id]

    @cards = Card.all

    if @query.present?
      @cards = @cards.where('name LIKE ?', "%#{@query}%")
    end

    if card_set_id.present?
      @cards = @cards.where(card_set_id: card_set_id)
    end

    if category_id.present?
      @cards = @cards.where(category_id: category_id)
    end

    @cards = Kaminari.paginate_array(@cards).page(params[:page]).per(20)

    respond_to do |format|
      format.html { render :index } # renders the default HTML view (index.html.erb)
      format.json { render json: @cards.map { |card| card_with_image_url(card) } }
    end
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      respond_to do |format|
        format.html { redirect_to @card, notice: "Card was successfully created." }
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
        format.html { redirect_to @card, notice: "Card was successfully updated." }
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
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
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
