class PropertiesController < ApplicationController
  before_action :set_property, only: [:show]

  def index
    @regions = Region.all
    @proposals = Proposal.all
   
  end
  

  def search 
    @region = Region.find(params[:region])
    @properties = @region.properties 
  
  end

  def show
  end

  def new
    @property = Property.new
    @regions = Region.all
    @property_types = PropertyType.all
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      flash[:success] = 'Imóvel cadastrado com sucesso'
      redirect_to @property
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      @regions = Region.all
      @property_types = PropertyType.all
      render :new
    end
  end

  def edit
    @regions = Region.all
    @property_types = PropertyType.all
    @property = Property.find(params[:id])
  end

  def update
    @regions = Region.all
    @property_types = PropertyType.all
    @property = Property.find(params[:id])
    if @property.update(property_params)
    flash[:success] = 'Imóvel editado com sucesso'
    redirect_to @property
    else
    flash[:alert] = 'Não foi possível editar a propriedade'
    render :edit
    end
    
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :description, :property_type_id,
                                     :region_id, :rent_purpose, :area,
                                     :room_quantity, :accessibility,
                                     :allow_pets, :allow_smokers,
                                     :maximum_guests, :minimum_rent,
                                     :maximum_rent, :daily_rate, :main_photo)
  end
  
end
