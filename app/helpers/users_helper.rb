module UsersHelper
	def invitation_code(user)
		invitation = Invitation.find_by(owner_id: user.id)
		if invitation.present?
			return invitation.public_uid.to_s
		else
			return "登録されていません"
		end
	end
end
