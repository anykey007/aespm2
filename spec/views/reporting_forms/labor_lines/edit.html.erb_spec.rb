require 'spec_helper'

describe "reporting_forms/labor_lines/edit" do
  before(:each) do
    @line = assign(:reporting_forms_labor_line, stub_model(ReportingForms::LaborLine))
  end

  it "renders the edit reporting_forms_labor_line form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reporting_forms_labor_lines_path(@line), :method => "post" do
    end
  end
end
