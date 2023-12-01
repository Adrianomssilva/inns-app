class Api::V1::ReservationsController < Api::V1::ApiController

  def create
    begin
    @reservation = Reservation.new(reservation_params)
    if @reservation.valid?
      render status: 200, json: @reservation
    else
      render status: 412, json: {errors: @reservation.errors.full_messages}
    end
    rescue
      render status: 500
    end

  end


  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status, :total_value)
  end
end
