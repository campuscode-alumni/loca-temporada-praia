class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :user]
  before_action :authenticate_realtor!, only: [:approve]

  def new
    @proposal = Proposal.new
  end

  def user
    @user = current_user
    @proposals = @user.proposals 
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
    if user_signed_in? or realtor_signed_in?
      @proposal = Proposal.find(params[:id])
    else
      redirect_to root_path, alert: 'Favor realizar seu login'
    end
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