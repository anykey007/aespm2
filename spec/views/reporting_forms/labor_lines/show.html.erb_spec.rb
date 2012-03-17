require 'spec_helper'

describe "reporting_forms/labor_lines/show" do
  before(:each) do
    @line = assign(:reporting_forms_labor_line, stub_model(ReportingForms::LaborLine))
  end

  it "renders attributes in <p>" do
    render
  end
end
