require 'spec_helper'

describe "reportings/balances/edit" do
  before(:each) do
    @reportings_balance = assign(:reportings_balance, stub_model(Reportings::Balance))
  end

  it "renders the edit reportings_balance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reportings_balances_path(@reportings_balance), :method => "post" do
    end
  end
end
