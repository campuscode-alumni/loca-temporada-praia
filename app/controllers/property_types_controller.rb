class PropertyTypesController < ApplicationController
  before_action :set_property_type, only: [:show,:edit,:update]

  def index
   @property_types = PropertyType.all
  end

  def edit
  end

  def update
    if @property_type.update(property_type_params)
      redirect_to property_type_index_path
    else
      render :edit
    end
  end

  def show; end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.new(property_type_params)
    if @property_type.save
      flash[:success] = 'Tipo do imóvel cadastrado com sucesso'
      redirect_to @property_type
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  private

  def property_type_params
    params.require(:property_type).permit(:name)
  end

  def set_property_type
    @property_type = PropertyType.find(params[:id])
  end
end
