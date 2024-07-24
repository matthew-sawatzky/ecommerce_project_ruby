class PagesController < ApplicationController
  def about
    @static_page = StaticPage.find_by(title: 'About')
    if @static_page.nil?
      redirect_to root_path, alert: "About page not found."
    end
  end
  def home
    # Code for the home action
  end
end
