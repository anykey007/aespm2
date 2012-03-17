require 'spec_helper'

describe "reportings/labors/edit" do
  before(:each) do
    @report = assign(:reportings_labor, stub_model(Reportings::Labor))
  end

  it "renders the edit reportings_labor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_labors_path(@report), :method => "post" do
    end
  end
end
