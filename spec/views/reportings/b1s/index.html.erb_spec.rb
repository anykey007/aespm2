require 'spec_helper'

describe "reportings_b1s/index" do
  before(:each) do
    assign(:reportings_b1s, [
      stub_model(Reportings::B1),
      stub_model(Reportings::B1)
    ])
  end

  it "renders a list of reportings_b1s" do
    render
  end
end
