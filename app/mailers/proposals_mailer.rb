class ProposalsMailer < ApplicationMailer 

  def notify_user(proposal)
    @proposal = proposal
    mail(to: @proposal.user.email, subject: 'Proposta enviada com sucesso')
  end
end