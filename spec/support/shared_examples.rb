shared_examples "requires sign in" do
  it "redirects to login path" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "requires admin" do  
  it "redirects to home" do
    set_current_user
    get :new
    expect(response).to redirect_to home_path
  end
end
