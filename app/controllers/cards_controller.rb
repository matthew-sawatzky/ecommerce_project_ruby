class CardsController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart, :remove_from_cart, :update_cart_item]

  def index
    @cards = Card.all.page(params[:page])
  end

  def show
    @card = Card.find(params[:id])
  end

  def search
    @query = params[:query]
    @card_set_id = params[:card_set_id]    
    @cards = Card.all
    @cards = @cards.where("name ILIKE ? OR description ILIKE ?", "%#{@query}%", "%#{@query}%") if @query.present?
    @cards = @cards.where(card_set_id: @card_set_id) 
    if @card_set_id.present? && @card_set_id != ""
    @cards = @cards.page(params[:page])
  end

  def add_to_cart
    card = Card.find(params[:id])
    user_id = current_user.id

    active_order = Order.find_or_create_by(order_status: 1, user_id:) do |order|
    order.order_total = card.price
  end

    item = Item.create(
      card_id: card.id,
      order_id: active_order.id,
      quantity: 1
    )

    session[:cart] ||= []
    session[:cart] << item.id unless session[:cart].include?(item.id)

    redirect_to root_path, notice: "Item added to cart."
  end

  def remove_from_cart
    item = Item.find(params[:id])
    item.destroy
    session[:cart].delete(item.id)
    redirect_to root_path, notice: "Item removed from cart."
  end

  def update_cart_item
    item = Item.find(params[:id])
    if item.update(quantity: params[:quantity])
      redirect_to root_path, notice: "Item quantity updated successfully."
    else
      redirect_to root_path, alert: "Failed to update item quantity."
    end
  end
end
