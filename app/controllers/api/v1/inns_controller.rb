class Api::V1::InnsController < Api::V1::ApiController

  def index
    @inns = Inn.all.published
    render status: 200, json: @inns
  end

  def search
    @query = params["query"]
    @inns = Inn.published.where("brand_name LIKE ? ","%#{@query}%").order(:brand_name)
    render status: 200, json: @inns
  end

end
