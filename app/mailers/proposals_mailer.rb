class ProposalsMailer < ApplicationMailer 

  def notify_user(user)
    @user = user
    mail(to: @user.email, subject: 'Proposta enviada com sucesso')
  end
end