class ReservationsController < ApplicationController

  before_action :authenticate_user!, only: [:confirmation, :create]

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user
    if @reservation.valid?
      session[:temp_reserve] = reservation_params.merge("total_value" => @reservation.total_value)
      redirect_to confirmation_new_room_reservation_path
    else
      flash.now[:notice] = 'Verifique os erros.'
      render 'new'
    end
  end

  def confirmation
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(session[:temp_reserve])
  end

  def reservation_create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(session[:temp_reserve])
    @reservation.user = current_user
    if @reservation.save
      redirect_to my_reservations_path, notice: 'Sua reserva foi confirmada'
    else
      flash.now[:notice] = 'Verifique os erros'
      render 'new'
    end
  end

  def my_reservations
    @reservation = current_user.reservations

  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status, :total_value)

  end

end
