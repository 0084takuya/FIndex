module UsersHelper
  def user_id_to_user(user_id)
    User.find(user_id)
  end
end
