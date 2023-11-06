class HomeController < ApplicationController

  def index
    @inns = Inn.published
  end
end
