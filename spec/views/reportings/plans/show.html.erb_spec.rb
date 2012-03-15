require 'spec_helper'

describe "reportings/plans/show" do
  before(:each) do
    @reportings_plan = assign(:reportings_plan, stub_model(Reportings::Plan))
  end

  it "renders attributes in <p>" do
    render
  end
end
