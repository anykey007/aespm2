require 'spec_helper'

describe "Reportings::Plans" do
  describe "GET /reportings_plans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get reportings_plans_path
      response.status.should be(200)
    end
  end
end
