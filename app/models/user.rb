class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :proposals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :cpf, presence: { message: 'não pode ficar em branco' }, uniqueness: { message: 'Já Cadastrado' }, cpf: true

end
