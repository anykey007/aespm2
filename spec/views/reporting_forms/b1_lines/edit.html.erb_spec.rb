require 'spec_helper'

describe "reporting_forms_b1_lines/edit" do
  before(:each) do
    @b1_line = assign(:b1_line, stub_model(ReportingForms::B1Line))
  end

  it "renders the edit b1_line form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reporting_forms_b1_lines_path(@b1_line), :method => "post" do
    end
  end
end
