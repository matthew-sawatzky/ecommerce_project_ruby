class StaticPagesController < ApplicationController
  def show
    @static_page = StaticPage.find_by(title: params[:id])
    return unless @static_page.nil?

    redirect_to root_path, alert: "Page not found."
  end
end
