class ApplicationController < ActionController::Base
  # before_action :set_card_sets
  before_action :authenticate_user!
  before_action :load_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = %i[username email province_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
  # private

  # def set_card_sets
  #   @card_sets = CardSet.all
  # end
  # protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      super
    end
  end

  private

  def load_cart
    if user_signed_in?
      active_order = Order.find_by(order_status: 1, user_id: current_user.id)
      @cart = active_order ? active_order.items : []
    else
      @cart = []
    end
  end
end
