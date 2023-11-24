class CheckOutsController < ApplicationController

  def new
    @reserva = Reservation.find(params[:reservation_id])
    @check_out = Check_out.new
  end
end
