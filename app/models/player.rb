class Player < ApplicationRecord
  has_many :watches
  has_many :buy_histories
  has_many :sell_histories
end
