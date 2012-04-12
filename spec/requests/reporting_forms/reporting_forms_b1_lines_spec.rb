require 'spec_helper'

describe "ReportingForms::B1Lines" do
  describe "GET /reporting_forms_b1_lines" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get reporting_forms_b1_lines_path
      response.status.should be(200)
    end
  end
end
