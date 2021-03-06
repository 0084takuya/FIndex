class User < ApplicationRecord
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  generate_public_uid

  attribute :agree_term_of_service, :boolean, default: false
  attribute :birthday_year, :integer
  attribute :birthday_month, :integer
  attribute :birthday_day, :integer
  has_many :watches
  has_many :buy_histories
  has_many :sell_histories
  has_many :user_stocks
  has_many :bonus_points

  validates :email, uniqueness: { message: :taken }, email: { allow_blank: true, uniqueness: { case_sensitive: false } }, presence: { message: :blank }
  validates :password, presence: true, length: { minimum: 6, message: :too_short }
  validates :password_confirmation, presence: true, length: { minimum: 6, message: :too_short }
  validates :phone, uniqueness: { message: :taken }, presence: true, format: { with: /(?:\d{10}|\d{3}-\d{3}-\d{4}|\d{2}-\d{4}-\d{4}|\d{3}-\d{4}-\d{4})/ }
  validates :user_name, presence: true
  validates :birthday_year, presence: true
  validates :birthday_month, presence: true
  validates :birthday_day, presence: true
  validate :date_before_limit

  def to_param
    public_uid
  end

  private
  def date_before_limit
    return if birthday.nil?
    errors.add(:birthday, :invalid) if birthday < Date.new(1900, 1, 1)
  end
end
