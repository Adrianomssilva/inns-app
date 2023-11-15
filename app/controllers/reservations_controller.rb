class ReservationsController < ApplicationController

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    if @reservation.save
      redirect_to Something_path
    else
      flash.now[:notice] = 'Ocorreu um erro...'
      render 'new'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status)

  end

end
