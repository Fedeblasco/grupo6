class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         #:recoverable, 
         :rememberable, :validatable

  has_many :reserva, dependent: :destroy

	has_many :puja

	has_one :solivip

  # Valida nombre y apellido
  validates :nombre, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "solo se aceptan letras" }
  validates :apellido, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "solo se aceptan letras" }

  # Validaciones de la tarjeta
  validates :tarjeta_numero, presence: true, format: {with: /\A\d+\z/}, length: {is: 16} 
  validates :tarjeta_cvv, presence: true, format: {with: /\A\d+\z/}, length: {is: 3} 
  validates :tarjeta_mes, presence: true, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 12
  }

  validates :tarjeta_ano, presence: true, numericality: { 
    only_integer: true
  }

  validate :tarjeta_vencimiento

  # Validacion de la fecha de nacimiento

  validate :fecha_nac_limits

  validate :password_complexity

  private

  def fecha_nac_limits
    if ((fecha_nac + 18.years) >= Date.today)
      errors.add(:fecha_nac, "No eres mayor de 18 años de edad")
    end
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,70}$/

    errors.add :password, ' no es válida. El tamaño debe ser de 10 a 70 caracteres e incluir al menos una letra mayúscula, una minúscula y un número'
  end

  # Funcion para verificar el vencimiento de la tarjeta
  def tarjeta_vencimiento

    # Si el año es el actual
    if tarjeta_ano.to_i == Date.today.year.to_i

      # Y si el mes ya paso
      if tarjeta_mes.to_i < Date.today.month.to_i
        errors.add(:base, "La tarjeta esta vencida")
      end

    # Si el año es anterior tambien la rebota 
    elsif tarjeta_ano.to_i < Date.today.year.to_i
      errors.add(:base, "La tarjeta esta vencida")
    end
  end
end
