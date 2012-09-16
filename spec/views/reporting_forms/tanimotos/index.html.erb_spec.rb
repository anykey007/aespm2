require 'spec_helper'

describe "reporting_forms_tanimotos/index" do
  before(:each) do
    assign(:reporting_forms_tanimotos, [
      stub_model(ReportingForms::Tanimoto),
      stub_model(ReportingForms::Tanimoto)
    ])
  end

  it "renders a list of reporting_forms_tanimotos" do
    render
  end
end
