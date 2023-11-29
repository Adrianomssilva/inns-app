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

  def show
    begin
    @inn = Inn.find(params[:id])
    @nota = Inn.rating(@inn) if @inn.avaliations.present?
    @nota = "--" if @inn.avaliations.nil?
    @inn = @inn.attributes.merge(nota: @nota)
    @inn = @inn.except("created_at", "updated_at", "registration_number", "corporate_name")
    render status: 200, json: @inn
    rescue
    render status: 404
    end
  end

end
