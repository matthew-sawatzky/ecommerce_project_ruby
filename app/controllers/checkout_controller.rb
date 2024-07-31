class CheckoutController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is logged in

  def index
    @orders = current_user.order.includes(:items)
  end
end
