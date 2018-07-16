class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def new
    @proposal = Proposal.new
  end
  
  def index
    @proposals = Proposal.all
  end

  def create
    @proposal = current_user.proposals.build proposal_params
    @proposal.property = Property.find(params[:property_id])
 
    if @proposal.save
      redirect_to proposal_path(@proposal), notice: 'Proposta enviada com sucesso'
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def approve
    @proposal = Proposal.find(params[:proposal_id])
    @proposal.approved!
    redirect_to property_path(@proposal.property), notice: 'Proposta aprovada com sucesso!'
  end
  
  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :end_date, :rent_purpose, :total_guests, :pet)
  end
end