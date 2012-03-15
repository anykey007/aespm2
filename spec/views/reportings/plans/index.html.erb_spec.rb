require 'spec_helper'

describe "reportings/plans/index" do
  before(:each) do
    assign(:reportings_plans, [
      stub_model(Reportings::Plan),
      stub_model(Reportings::Plan)
    ])
  end

  it "renders a list of reportings/plans" do
    render
  end
end
