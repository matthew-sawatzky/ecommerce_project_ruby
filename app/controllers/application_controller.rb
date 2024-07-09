class ApplicationController < ActionController::Base
  before_action :load_sets

  private

  def load_sets
    @sets = Set.all
  end
end
