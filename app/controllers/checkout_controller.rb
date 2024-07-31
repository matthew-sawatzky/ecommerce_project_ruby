class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.order.includes(:items)
  end
end
