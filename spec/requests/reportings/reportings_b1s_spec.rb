require 'spec_helper'

describe "Reportings::B1s" do
  describe "GET /reportings_b1s" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      sign_in_as_a_valid_user
      company = Company.create!(name: "company1", EDRPOY: "1234324")
      get company_reportings_b1s_path(company)
      response.status.should be(200)
    end
  end
end
