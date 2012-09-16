require 'spec_helper'

describe "reporting_forms_tanimotos/edit" do
  before(:each) do
    @tanimoto = assign(:tanimoto, stub_model(ReportingForms::Tanimoto))
  end

  it "renders the edit tanimoto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reporting_forms_tanimotos_path(@tanimoto), :method => "post" do
    end
  end
end
