require "spec_helper"

describe Reportings::LaborsController do
  describe "routing" do

    it "routes to #index" do
      get("/reportings/labors").should route_to("reportings/labors#index")
    end

    it "routes to #new" do
      get("/reportings/labors/new").should route_to("reportings/labors#new")
    end

    it "routes to #show" do
      get("/reportings/labors/1").should route_to("reportings/labors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportings/labors/1/edit").should route_to("reportings/labors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportings/labors").should route_to("reportings/labors#create")
    end

    it "routes to #update" do
      put("/reportings/labors/1").should route_to("reportings/labors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportings/labors/1").should route_to("reportings/labors#destroy", :id => "1")
    end

  end
end
