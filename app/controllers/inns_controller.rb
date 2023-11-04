class InnsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :create, :my_inn]
  def new
    @inn = Inn.new
  end

  def create
    @inn = Inn.new(inn_params)
    @inn.owner = current_owner
    if @inn.save
      redirect_to my_inn_path, notice: 'Pousada cadastrada com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a pousada'
    end

  end

  def edit

  end

  def my_inn
    @inn = current_owner.inn
  end

  def publish
    inn = Inn.find(params[:id])
    inn.published!
    redirect_to my_inn_path, notice: 'Sua Pousada foi publicada!'
  end

  def hidden
    inn = Inn.find(params[:id])
    inn.hidden!
    redirect_to my_inn_path, notice: 'Sua Pousada saiu do ar!'
  end

  private

  def inn_params
    params.require(:inn).permit(:brand_name, :corporate_name, :registration_number, :phone, :email, :address, :neighborhood, :state, :city, :cep, :payment_options, :pets, :policies, :description, :check_in, :check_out, :owner_id, :status)
  end

end
