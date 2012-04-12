require "spec_helper"

describe ReportingForms::B1LinesController do
  describe "routing" do

    it "routes to #index" do
      get("/reporting_forms_b1_lines").should route_to("reporting_forms_b1_lines#index")
    end

    it "routes to #new" do
      get("/reporting_forms_b1_lines/new").should route_to("reporting_forms_b1_lines#new")
    end

    it "routes to #show" do
      get("/reporting_forms_b1_lines/1").should route_to("reporting_forms_b1_lines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reporting_forms_b1_lines/1/edit").should route_to("reporting_forms_b1_lines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reporting_forms_b1_lines").should route_to("reporting_forms_b1_lines#create")
    end

    it "routes to #update" do
      put("/reporting_forms_b1_lines/1").should route_to("reporting_forms_b1_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reporting_forms_b1_lines/1").should route_to("reporting_forms_b1_lines#destroy", :id => "1")
    end

  end
end
