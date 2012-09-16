require 'spec_helper'

describe "reportings_tanimotos/show" do
  before(:each) do
    @tanimoto = assign(:tanimoto, stub_model(Reportings::Tanimoto))
  end

  it "renders attributes in <p>" do
    render
  end
end
