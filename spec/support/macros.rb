def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user.id
end

def set_current_admin(admin=nil)
  session[:user_id] = (admin || Fabricate(:admin)).id
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

def click_on_video(video)
  find("a[href='/videos/#{video.id}']").click 
end
  
def sign_out
  visit logout_path
end

def get_stripe_token_id
  Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  @token ||= Stripe::Token.create(
    :card => {
    :number => "4242424242424242",
    :exp_month => 11,
    :exp_year => 2015,
    :cvc => "123"
    }
  )
  @token.id
end