class PriceRangesController < ApplicationController 
 
  def new
    @price_range = PriceRange.new
    @property = Property.find(params[:property_id])
  end

  def create
    @price_range = PriceRange.new(params_price_range)
    @property = Property.find(params[ :property_id ])
    @price_range.property = @property
    if @price_range.save
      flash[:success] = 'Temporada Cadastrada com sucesso!!!'
      redirect_to @property
    else
      render :new
    end
  end


  private 

  def params_price_range
    params.require(:price_range).permit(:description, :start_date, :end_date, :daily_rate)
  end

end