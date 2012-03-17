require 'spec_helper'

describe "reportings/balances/show" do
  before(:each) do
    @report = assign(:reportings_balance, stub_model(Reportings::Balance))
  end

  it "renders attributes in <p>" do
    render
  end
end
