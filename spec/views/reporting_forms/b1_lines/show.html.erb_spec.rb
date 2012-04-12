require 'spec_helper'

describe "reporting_forms_b1_lines/show" do
  before(:each) do
    @b1_line = assign(:b1_line, stub_model(ReportingForms::B1Line))
  end

  it "renders attributes in <p>" do
    render
  end
end
