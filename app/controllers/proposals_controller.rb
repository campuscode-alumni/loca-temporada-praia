class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new proposal_params
    @proposal.property = Property.find(params[:property_id])
 
    if @proposal.save
      flash[:notice] = 'Proposta enviada com sucesso'
      redirect_to property_proposal_path(@proposal.property, @proposal)
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :end_date, :rent_purpose, :total_guests, :pet)
  end
end