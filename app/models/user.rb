class User < ApplicationRecord
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  attribute :agree_term_of_service, :boolean, default: false
  attribute :birthday_year, :integer
  attribute :birthday_month, :integer
  attribute :birthday_day, :integer
  has_many :watches
  has_many :buy_histories
  has_many :sell_histories
  has_many :user_stocks

  validates :email, email: { allow_blank: true, uniqueness: { case_sensitive: false } }, presence: { message: :blank }
  validates :password, presence: true, length: { minimum: 6, message: :too_short }
  validates :password_confirmation, presence: true, length: { minimum: 6, message: :too_short }
  validates :phone, presence: true # telephone_number: {country: :ja, types: [:fixed_line, :mobile]}
  validates :user_name, presence: true
  validates :birthday_year, presence: true
  validates :birthday_month, presence: true
  validates :birthday_day, presence: true
  validate :date_before_limit

  private
  def date_before_limit
    errors.add(:birthday, :invalid) if birthday < Date.new(1900, 1, 1)
  end
end
