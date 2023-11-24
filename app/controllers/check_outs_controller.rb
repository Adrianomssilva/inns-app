class CheckOutsController < ApplicationController

  def new
    @reserva = Reservation.find(params[:reservation_id])
    @check_out = CheckOut.new
    @saida = Time.now
    @total = CheckOut.total_calculate(@reserva, @saida)
  end


  private

  def check_out_params
    params.require(:check_out).permit(:reservation_id, :exit, :total)
  end

end
