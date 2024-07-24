class ApplicationController < ActionController::Base
  # before_action :set_card_sets

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
end
