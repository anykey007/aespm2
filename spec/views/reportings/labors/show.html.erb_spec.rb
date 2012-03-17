require 'spec_helper'

describe "reportings/labors/show" do
  before(:each) do
    @report = assign(:reportings_labor, stub_model(Reportings::Labor))
  end

  it "renders attributes in <p>" do
    render
  end
end
