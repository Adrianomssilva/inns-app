class ReservationsController < ApplicationController

  before_action :authenticate_user!, only: [:confirmation]
  before_action :authenticate_owner!, only: [:index, :owner_cancel]

  def index
    @rooms = current_owner.inn.rooms
  end

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
      session.delete(:temp_reserve)
    else
      flash.now[:notice] = 'Verifique os erros'
      render 'new'
    end
  end

  def my_reservations
    @reservation = current_user.reservations

  end

  def cancel
    @reservation = Reservation.find(params[:id])

    if Time.now <= @reservation.start_date - 7.days
      @reservation.canceled!
      redirect_to my_reservations_path, notice: 'Sua reserva foi cancelada'
    else
      redirect_to my_reservations_path, notice: 'Você não pode mais cancelar a reserva, entre em contato
                                                  com a pousada.'
    end
  end

  def owner_cancel
    @reservation = Reservation.find(params[:id])

    if Time.now >= @reservation.start_date + 3.days
      @reservation.canceled!
      redirect_to reservations_path, notice: 'A reserva foi cancelada'
    else
      redirect_to reservations_path, notice: 'Você ainda não pode cancelar essa reserva'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :guest_number, :status, :total_value)

  end

end
