class Player < ApplicationRecord
  has_many :watches
  has_many :buy_histories
  has_many :sell_histories

  scope :buy_asc, -> { order(buy_price: :asc) }
  scope :buy_desc, -> { order(buy_price: :desc) }
  scope :sell_asc, -> { order(ask_price: :asc) }
  scope :sell_desc, -> { order(ask_price: :desc) }
end
