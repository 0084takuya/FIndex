class BonusPoint < ApplicationRecord
	before_save :set_expire
  belongs_to :user

	def set_expire
		date = DateTime.now
		self.expire_at = date.next_month
	end
end
