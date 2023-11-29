class Api::V1::ReservationsController < Api::V1::ApiController

  def availability
    @reservation = Reservation.new(reservation_params)
    if @reservation.valid?
      render status: 200, json: @reservation
    end
  end


  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status, :total_value)

  end
end
