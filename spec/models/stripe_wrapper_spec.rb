require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "it makes a successful charge", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 1,
            :exp_year => 2018,
            :cvc => "314"
          },
        ).id       
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "a valid charge"
          )

        expect(response).to be_successful
      end
      
      it "handles the card decline", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 1,
            :exp_year => 2018,
            :cvc => "314"
          },
        ).id       
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "card declined"
          )

        expect(response).not_to be_successful
      end
      
      it "returns the error message", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 1,
            :exp_year => 2018,
            :cvc => "314"
          },
        ).id       
        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "card declined"
          )

        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end