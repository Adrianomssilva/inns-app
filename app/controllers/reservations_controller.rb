class ReservationsController < ApplicationController

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    room = Room.find(params[:room_id])
    reservation = room.reservations.build(reservation_params)
    if reservation.valid?
    session[:temp_reserve] = reservation_params
    redirect_to confirmation_new_room_reservation_path
    else
      flash.now[:notice] = 'Verifique os erros.'
    render 'new'
    end
  end

  def confirmation
    @room = Room.find(params[:room_id])
    @temp_reserve = session[:temp_reserve]
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status)

  end

end
