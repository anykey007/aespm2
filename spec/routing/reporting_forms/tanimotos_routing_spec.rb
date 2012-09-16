require "spec_helper"

describe ReportingForms::TanimotosController do
  describe "routing" do

    it "routes to #index" do
      get("/reporting_forms_tanimotos").should route_to("reporting_forms_tanimotos#index")
    end

    it "routes to #new" do
      get("/reporting_forms_tanimotos/new").should route_to("reporting_forms_tanimotos#new")
    end

    it "routes to #show" do
      get("/reporting_forms_tanimotos/1").should route_to("reporting_forms_tanimotos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reporting_forms_tanimotos/1/edit").should route_to("reporting_forms_tanimotos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reporting_forms_tanimotos").should route_to("reporting_forms_tanimotos#create")
    end

    it "routes to #update" do
      put("/reporting_forms_tanimotos/1").should route_to("reporting_forms_tanimotos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reporting_forms_tanimotos/1").should route_to("reporting_forms_tanimotos#destroy", :id => "1")
    end

  end
end
