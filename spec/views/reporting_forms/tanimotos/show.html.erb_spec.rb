require 'spec_helper'

describe "reporting_forms_tanimotos/show" do
  before(:each) do
    @tanimoto = assign(:tanimoto, stub_model(ReportingForms::Tanimoto))
  end

  it "renders attributes in <p>" do
    render
  end
end
