require 'spec_helper'

describe "reporting_forms_tanimotos/new" do
  before(:each) do
    assign(:tanimoto, stub_model(ReportingForms::Tanimoto).as_new_record)
  end

  it "renders new tanimoto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reporting_forms_tanimotos_path, :method => "post" do
    end
  end
end
