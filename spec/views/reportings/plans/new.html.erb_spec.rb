require 'spec_helper'

describe "reportings/plans/new" do
  before(:each) do
    assign(:reportings_plan, stub_model(Reportings::Plan).as_new_record)
  end

  it "renders new reportings_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_plans_path, :method => "post" do
    end
  end
end
