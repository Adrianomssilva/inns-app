class Api::V1::InnsController < Api::V1::ApiController
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500

  def index
      @inns = Inn.all.published
      render status: 200, json: @inns
  end

  def search

    @query = params["query"]
    if @query.present?
    @inns = Inn.where("brand_name LIKE ? ","%#{@query}%").order(:brand_name).published
    render status: 200, json: @inns
    else
      render status: 400, json: {Error: 'campo em branco'}
    end
  end

  def show
    begin
    @inn = Inn.find(params[:id])
    @nota = Inn.rating(@inn) if @inn.avaliations.present?
    @nota = "--" if @inn.avaliations.nil?
    @inn = @inn.attributes.merge(nota: @nota)
    render status: 200, json: @inn.except("created_at", "updated_at", "registration_number", "corporate_name")
    rescue
    render status: 404
    end
  end

  private

  def return_500
    render status: 500
  end
end
