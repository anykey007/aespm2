require 'spec_helper'

describe "reporting_forms/labor_lines/new" do
  before(:each) do
    assign(:reporting_forms_labor_line, stub_model(ReportingForms::LaborLine).as_new_record)
  end

  it "renders new reporting_forms_labor_line form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reporting_forms_labor_lines_path, :method => "post" do
    end
  end
end
