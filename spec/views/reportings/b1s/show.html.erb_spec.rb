require 'spec_helper'

describe "reportings_b1s/show" do
  before(:each) do
    @b1 = assign(:b1, stub_model(Reportings::B1))
  end

  it "renders attributes in <p>" do
    render
  end
end
