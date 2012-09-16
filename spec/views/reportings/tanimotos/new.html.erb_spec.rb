require 'spec_helper'

describe "reportings_tanimotos/new" do
  before(:each) do
    assign(:tanimoto, stub_model(Reportings::Tanimoto).as_new_record)
  end

  it "renders new tanimoto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_tanimotos_path, :method => "post" do
    end
  end
end
