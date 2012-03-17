require 'spec_helper'

describe "reportings/labors/index" do
  before(:each) do
    assign(:reportings_labors, [
      stub_model(Reportings::Labor),
      stub_model(Reportings::Labor)
    ])
  end

  it "renders a list of reportings/labors" do
    render
  end
end
