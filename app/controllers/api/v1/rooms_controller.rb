class Api::V1::RoomsController < Api::V1::ApiController

  rescue_from ActiveRecord::ActiveRecordError, with: :return_500

  def index
    begin
    @inns = Inn.find(params[:inn_id])
    @rooms = @inns.rooms.available
    render status: 200 , json: @rooms
    rescue
      return render status: 404
    end
  end

  private

  def return_500
    render status: 500
  end
end
