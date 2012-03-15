require 'spec_helper'

describe "reportings/balances/new" do
  before(:each) do
    assign(:reportings_balance, stub_model(Reportings::Balance).as_new_record)
  end

  it "renders new reportings_balance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_balances_path, :method => "post" do
    end
  end
end
