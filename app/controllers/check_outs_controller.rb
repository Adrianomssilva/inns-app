class CheckOutsController < ApplicationController

  def new
    @reserva = Reservation.find(params[:reservation_id])
    @check_out = CheckOut.new
    @check_out.exit = Time.now
    @total = CheckOut.total_calculate(@reserva, @check_out.exit)
  end


  private

  def check_out_params
    params.require(:check_out).permit(:reservation_id, :exit, :total)
  end

end
