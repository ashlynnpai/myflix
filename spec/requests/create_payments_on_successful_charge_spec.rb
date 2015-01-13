require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
{
  "id"=> "evt_15KZdqJwPS7CsuHva6Aqr3QX",
  "created"=> 1421174630,
  "livemode"=> false,
  "type"=> "charge.succeeded",
  "data"=> {
    "object"=> {
      "id"=> "ch_15KZdqJwPS7CsuHvw8lj228G",
      "object"=> "charge",
      "created"=> 1421174630,
      "livemode"=> false,
      "paid"=> true,
      "amount"=> 999,
      "currency"=> "usd",
      "refunded"=> false,
      "captured"=> true,
      "card"=> {
        "id"=> "card_15KZdpJwPS7CsuHvVuCSoOc1",
        "object"=> "card",
        "last4"=> "4242",
        "brand"=> "Visa",
        "funding"=> "credit",
        "exp_month"=> 12,
        "exp_year"=> 2015,
        "fingerprint"=> "rLAb2nRO0fHnP9cK",
        "country"=> "US",
        "name"=> nil,
        "address_line1"=> nil,
        "address_line2"=> nil,
        "address_city"=> nil,
        "address_state"=> nil,
        "address_zip"=> nil,
        "address_country"=> nil,
        "cvc_check"=> "pass",
        "address_line1_check"=> nil,
        "address_zip_check"=> nil,
        "dynamic_last4"=> nil,
        "customer"=> "cus_5VapeF51RrbKU3"
      },
      "balance_transaction"=> "txn_15KZdqJwPS7CsuHvJ9IzERK4",
      "failure_message"=> nil,
      "failure_code"=> nil,
      "amount_refunded"=> 0,
      "customer"=> "cus_5VapeF51RrbKU3",
      "invoice"=> "in_15KZdqJwPS7CsuHvYv5tDthz",
      "description"=> nil,
      "dispute"=> nil,
      "metadata"=> {},
      "statement_descriptor"=> "vpass charge",
      "fraud_details"=> {},
      "receipt_email"=> nil,
      "receipt_number"=> nil,
      "shipping"=> nil,
      "refunds"=> {
        "object"=> "list",
        "total_count"=> 0,
        "has_more"=> false,
        "url"=> "/v1/charges/ch_15KZdqJwPS7CsuHvw8lj228G/refunds",
        "data"=> []
      }
    }
  },
  "object"=> "event",
  "pending_webhooks"=> 1,
  "request"=> "iar_5Vap998eka1gQD",
  "api_version"=> "2014-12-22"
}
  end
  
  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end
  
  it "creates a payment associated with the user", :vcr do
    user = Fabricate(:user, customer_token: "cus_5VapeF51RrbKU3")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(user)
  end
  
  it "creates a payment with the amount", :vcr do
    user = Fabricate(:user, customer_token: "cus_5VapeF51RrbKU3")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end
  
  it "creates the payment with reference id", :vcr do
    user = Fabricate(:user, customer_token: "cus_5VapeF51RrbKU3")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_15KZdqJwPS7CsuHvw8lj228G")
  end
end