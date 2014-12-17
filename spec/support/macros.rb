def set_current_user
  user1 = Fabricate(:user)
  session[:user_id] = user1.id
end

def current_user
  User.find(session[:user_id])
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Sign in'
end