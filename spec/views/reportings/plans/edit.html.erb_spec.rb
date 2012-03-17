require 'spec_helper'

describe "reportings/plans/edit" do
  before(:each) do
    @report = assign(:reportings_plan, stub_model(Reportings::Plan))
  end

  it "renders the edit reportings_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_plans_path(@report), :method => "post" do
    end
  end
end
