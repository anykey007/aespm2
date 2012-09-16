require 'spec_helper'

describe "reportings_tanimotos/index" do
  before(:each) do
    assign(:reportings_tanimotos, [
      stub_model(Reportings::Tanimoto),
      stub_model(Reportings::Tanimoto)
    ])
  end

  it "renders a list of reportings_tanimotos" do
    render
  end
end
