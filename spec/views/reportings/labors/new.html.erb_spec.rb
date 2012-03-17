require 'spec_helper'

describe "reportings/labors/new" do
  before(:each) do
    assign(:reportings_labor, stub_model(Reportings::Labor).as_new_record)
  end

  it "renders new reportings_labor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_labors_path, :method => "post" do
    end
  end
end
