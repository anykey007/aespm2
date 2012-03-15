require 'spec_helper'

describe "reportings/balances/index" do
  before(:each) do
    assign(:reportings_balances, [
      stub_model(Reportings::Balance),
      stub_model(Reportings::Balance)
    ])
  end

  it "renders a list of reportings/balances" do
    render
  end
end
