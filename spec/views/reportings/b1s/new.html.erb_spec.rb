require 'spec_helper'

describe "reportings_b1s/new" do
  before(:each) do
    assign(:b1, stub_model(Reportings::B1).as_new_record)
  end

  it "renders new b1 form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_b1s_path, :method => "post" do
    end
  end
end
