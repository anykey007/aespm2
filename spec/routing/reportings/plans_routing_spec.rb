require "spec_helper"

describe Reportings::PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/reportings/plans").should route_to("reportings/plans#index")
    end

    it "routes to #new" do
      get("/reportings/plans/new").should route_to("reportings/plans#new")
    end

    it "routes to #show" do
      get("/reportings/plans/1").should route_to("reportings/plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportings/plans/1/edit").should route_to("reportings/plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportings/plans").should route_to("reportings/plans#create")
    end

    it "routes to #update" do
      put("/reportings/plans/1").should route_to("reportings/plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportings/plans/1").should route_to("reportings/plans#destroy", :id => "1")
    end

  end
end
