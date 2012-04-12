require 'spec_helper'

describe "reportings_b1s/edit" do
  before(:each) do
    @b1 = assign(:b1, stub_model(Reportings::B1))
  end

  it "renders the edit b1 form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_b1s_path(@b1), :method => "post" do
    end
  end
end
