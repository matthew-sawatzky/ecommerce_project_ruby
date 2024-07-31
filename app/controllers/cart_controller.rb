class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @items = current_user.orders.last&.items || []
  end

  def add
    @card = Card.find(params[:card_id])
    @order = current_user.orders.last || current_user.orders.create(order_total: 0)
    @item = @order.items.find_by(card_id: @card.id)
    if @item
      @item.update(quantity: @item.quantity + params[:quantity].to_i)
    else
      @order.items.create(card: @card, quantity: params[:quantity])
    end

    @order.update(order_total: @order.items.sum { |item| item.card.price * item.quantity })
    redirect_to cart_path, notice: "Item added to cart."
  end

  def checkout
    @order = current_user.orders.last
    if @order.update(status: "completed")
      redirect_to root_path, notice: "Order completed!"
    else
      redirect_to cart_path, alert: "Failed to complete the order."
    end
  end
end
