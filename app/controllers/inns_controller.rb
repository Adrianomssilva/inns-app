class InnsController < ApplicationController

  before_action :authenticate_owner!, only: [:new, :create, :my_inn, :edit, :update]
  before_action :fetch_inn, only: [:edit, :update, :show, :avaliations, :publish, :hidden]

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
      render 'new'
    end
  end

  def show
    @rooms = @inn.rooms.available
    @avaliations = @inn.avaliations
    if @avaliations.present?
      @nota = Inn.rating(@inn)
    else
    @nota = '--'
    end
  end

  def avaliations
    @avaliations = @inn.avaliations
    if @avaliations.present?
      @nota = Inn.rating(@inn)
    else
    @nota = '--'
    end
  end

  def edit
    if @inn.owner != current_owner
      redirect_to root_path, notice: 'Você não tem acesso a essa Pousada'
    end
  end

  def update
    if @inn.update(inn_params)
      redirect_to my_inn_path, notice: 'Pousada editada com sucesso.'

    else
      flash.now[:notice] = 'Não foi possível editar a pousada.'
      render 'edit'
    end

  end

  def search
    @query_city = params["query_city"]
    @query = params["query"]
    if @query_city.present?
    @inns = Inn.published.where("city = ?", "#{@query_city}").order(:brand_name)
    else
    @inns = Inn.published.where("city LIKE ? OR brand_name LIKE ? OR neighborhood LIKE ? ", "%#{@query}%", "%#{@query}%", "%#{@query}%").order(:brand_name)
    end
  end

  def my_inn
    @inn = current_owner.inn
  end

  def publish
    @inn.published!
    redirect_to my_inn_path, notice: 'Sua Pousada foi publicada!'
  end

  def hidden
    @inn.hidden!
    redirect_to my_inn_path, notice: 'Sua Pousada saiu do ar!'
  end

  private

  def inn_params
    params.require(:inn).permit(:brand_name, :corporate_name, :registration_number, :phone, :email, :address, :neighborhood, :state, :city, :cep, :payment_options, :pets, :policies, :description, :check_in, :check_out, :owner_id, :status)
  end

  def fetch_inn
    @inn = Inn.find(params[:id])
  end

end
