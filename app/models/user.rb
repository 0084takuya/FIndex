class User < ApplicationRecord
  has_secure_password
  attribute :agree_term_of_service, :boolean, default: false
  attribute :birthday_year, :integer
  attribute :birthday_month, :integer
  attribute :birthday_day, :integer
  has_many :watches
end
