require 'spec_helper'

describe "reporting_forms/labor_lines/index" do
  before(:each) do
    assign(:reporting_forms_labor_lines, [
      stub_model(ReportingForms::LaborLine),
      stub_model(ReportingForms::LaborLine)
    ])
  end

  it "renders a list of reporting_forms/labor_lines" do
    render
  end
end
