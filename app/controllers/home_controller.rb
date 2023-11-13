class HomeController < ApplicationController

  def index
    @inns = Inn.published
    @cities = Inn.published.select(:city).distinct
  end
end
