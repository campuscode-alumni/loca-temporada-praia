class RegionsController < ApplicationController
  before_action :set_region, only: [:show,:edit,:update]

  def all_regions
    @regions = Region.all
  end

  def edit
  end

  def update
   if @region.update(region_params)
      redirect_to region_all_regions_path
    else
      render :edit
    end
  end

  def index
  end

  def show; end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      flash[:success] = 'Região cadastrada com sucesso'
      redirect_to @region
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end

  def set_region
    @region = Region.find(params[:id])
  end
end
