require 'spec_helper'

describe 'Deactivate user on failed charge' do
  let(:event_data) do
    {
  "id"=> "evt_15LctmJwPS7CsuHvXFRUq0nX",
  #"id"=> "ch_15LctmJwPS7CsuHvDBHmrbPH",
  "object"=> "charge",
  "created"=> 1421425478,
  "livemode"=> false,
  "paid" => false,
  "amount"=> 999,
  "currency"=> "usd",
  "type"=> "charge.failed",
  "refunded" => false,
  "captured" => false,
  "card"=> {
    "id"=> "card_15LcsRJwPS7CsuHvFzHB56QE",
    "object"=> "card",
    "last4"=> "0341",
    "brand"=> "Visa",
    "funding"=> "credit",
    "exp_month"=> 1,
    "exp_year"=> 2018,
    "fingerprint"=> "Lw0f6IZCDJMXfN1k",
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
    "balance_transaction"=> nil,
    "failure_message"=> "Your card was declined.",
    "failure_code"=> "card_declined",
    "amount_refunded"=> 0,
    "customer"=> "cus_5WgEQVA4Flemfl",
    "invoice"=> nil,
    "description"=> "fail",
    "dispute"=> nil,
    "metadata"=> {},
    "statement_descriptor"=> "myflix",
    "fraud_details"=> {},
    "receipt_email"=> nil,
    "receipt_number"=> nil,
    "shipping"=> nil,
    "refunds"=> {
      "object"=> "list",
      "total_count"=> 0,
      "has_more"=> false,
      "url"=> "/v1/charges/ch_15LctmJwPS7CsuHvDBHmrbPH/refunds",
      "data"=> []
    }
  }

  end
  
  it "deactivates a user with the web hook data from stripe for charge failed", :vcr do
    user = Fabricate(:user, email: "fail@example.com", customer_token: "cus_5WgEQVA4Flemfl")
    post "/stripe_events", event_data
    expect(user.reload).not_to be_active
  end

end