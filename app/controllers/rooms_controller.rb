class RoomsController < ApplicationController

  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :fetch_room, only: [:show, :edit, :update, :unavailable, :available]

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.inn = current_owner.inn
    if @room.save
      redirect_to my_inn_path, notice: 'Quarto criado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível criar o quarto'
      render 'new'
    end
  end

  def show;  end

  def edit
    if current_owner != @room.inn.owner
      redirect_to my_rooms_path, notice: 'Você não tem acesso a esse quarto'
    end
  end

  def update
    if @room.update(room_params)
      redirect_to my_rooms_path, notice: 'Quarto editado com sucesso'
    else
      flash.now[:notice] = 'Quarto não foi editado'
      render 'edit'
    end
  end

  def unavailable
    @room.unavailable!
    redirect_to my_rooms_path, notice: "#{@room.name} indisponível"
  end

  def available
    @room.available!
    redirect_to my_rooms_path, notice: "#{@room.name} disponível"
  end

  def my_rooms
    @rooms = current_owner.inn.rooms
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :dimension, :capacity, :default_price, :bathroom, :balcony, :air_conditioning, :tv, :wardrobe, :safe, :pcd, :inn_id, :status)
  end

  def fetch_room
    @room = Room.find(params[:id])
  end
end
