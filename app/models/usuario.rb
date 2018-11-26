class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reserva, dependent: :destroy

	has_many :puja

	has_one :solivip

  # Validaciones de la tarjeta
  validates :tarjeta_numero, presence: true, format: {with: /\A\d+\z/}, length: {is: 16} 
  validates :tarjeta_cvv, presence: true, format: {with: /\A\d+\z/}, length: {is: 3} 
  validates :tarjeta_mes, presence: true, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 12
  }
  validates :tarjeta_ano, presence: true, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 2018,
    less_than_or_equal_to: 2100
  }

  # Validacion de la fecha de nacimiento

  validate :fecha_nac_limits

  private

  def fecha_nac_limits
    if ((fecha_nac + 18.years) >= Date.today)
      errors.add(:fecha_nac, "No eres mayor de 18 años de edad")
    end
  end
end
