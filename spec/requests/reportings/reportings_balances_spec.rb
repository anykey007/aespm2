require 'spec_helper'

describe "Reportings::Balances" do
  describe "GET /reportings_balances" do

    before(:each) do
      sign_in_as_a_valid_user
      @company ||= Factory(:company, :name => 'company', :user_id => @user.id)
#      visit '/activities'
    end

    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      company = create(:company)
      get company_reportings_balances_path(@company)
      response.status.should be(200)
    end

    it "new works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      company = create(:company)
      get new_company_reportings_balance_path(@company)
      response.status.should be(200)
    end
  end
end
