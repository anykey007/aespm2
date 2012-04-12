require 'spec_helper'

describe "reporting_forms_b1_lines/index" do
  before(:each) do
    assign(:reporting_forms_b1_lines, [
      stub_model(ReportingForms::B1Line),
      stub_model(ReportingForms::B1Line)
    ])
  end

  it "renders a list of reporting_forms_b1_lines" do
    render
  end
end
