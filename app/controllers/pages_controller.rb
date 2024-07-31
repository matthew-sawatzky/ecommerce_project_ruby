class PagesController < ApplicationController
  def show
    @static_page = StaticPage.find_by(title: params[:title])
    return unless @static_page.nil?

    render file: "#{Rails.root}/public/404.html", status: :not_found
    render :show
  end
end
