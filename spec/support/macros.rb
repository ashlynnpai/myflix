def set_current_user
  user1 = Fabricate(:user)
  session[:user_id] = user1.id
end

def current_user
  User.find(session[:user_id])
end