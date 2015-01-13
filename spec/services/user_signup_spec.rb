require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "with valid info and credit card" do
      
      let(:customer) { double(:customer, successful?:true, customer_token: "abcdef" ) }
      before do
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
      end
      
      it "creates user record" do
        UserSignup.new(Fabricate.build(:user)).sign_up("a_stripetoken", nil)
        expect(User.count).to eq(1)
      end
      it "stores the customer token from stripe" do
        UserSignup.new(Fabricate.build(:user)).sign_up("a_stripetoken", nil)
        expect(User.first.customer_token).to eq("abcdef")
      end
      it "makes the user follow the inviter" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        UserSignup.new(Fabricate.build(:user, email: 'friend@email.com', password: 'password', name: 'My Friend')).sign_up("a_stripetoken", invitation.token)
        friend = User.where(email: 'friend@email.com').first
        expect(friend.follows?(user)).to be_truthy
      end         
      it "makes the inviter follow the user" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        UserSignup.new(Fabricate.build(:user, email: 'friend@email.com', password: 'password', name: 'My Friend')).sign_up("a_stripetoken", invitation.token)
        friend = User.where(email: 'friend@email.com').first
        expect(user.follows?(friend)).to be_truthy
      end
      it "expires the invitation upon acceptance" do
        user = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: user, recipient_email: 'friend@email.com')
        UserSignup.new(Fabricate.build(:user, email: 'friend@email.com', password: 'password', name: 'My Friend')).sign_up("a_stripetoken", invitation.token)
        friend = User.where(email: 'friend@email.com').first
        expect(Invitation.first.token).to be_nil
      end
    end
          
    context "sending emails" do
      let(:customer) { double(:customer, successful?:true, customer_token: "abcdef" ) }
      before do
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user, email: "test@email.com")).sign_up("a_stripetoken", nil)
      end
      after { ActionMailer::Base.deliveries.clear }
      
      it "sends an email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end     
      it "sends to the right recipient" do
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["test@email.com"]
      end
      it "has the right content" do
        message = ActionMailer::Base.deliveries.last
        message.body.should include('MyFlix has one of the largest selections of videos around.')
      end    
    end
    
    context "with valid personal info and declined card" do
      it "does not create a new user record" do
        customer = double(:customer, successful?: false, error_message: "The payment did not complete.")
        StripeWrapper::Customer.should_receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user)).sign_up('1234', nil)
        expect(User.count).to eq(0)
      end   
    end
    
    context "with invalid personal info" do
      before { UserSignup.new(Fabricate.build(:user, password: "p")).sign_up("a_stripetoken", nil) }
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "does not charge the credit card" do
        StripeWrapper::Customer.should_not_receive(:create)
      end
    end
  end
end