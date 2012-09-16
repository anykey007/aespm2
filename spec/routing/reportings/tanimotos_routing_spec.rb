require "spec_helper"

describe Reportings::TanimotosController do
  describe "routing" do

    it "routes to #index" do
      get("/reportings_tanimotos").should route_to("reportings_tanimotos#index")
    end

    it "routes to #new" do
      get("/reportings_tanimotos/new").should route_to("reportings_tanimotos#new")
    end

    it "routes to #show" do
      get("/reportings_tanimotos/1").should route_to("reportings_tanimotos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportings_tanimotos/1/edit").should route_to("reportings_tanimotos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportings_tanimotos").should route_to("reportings_tanimotos#create")
    end

    it "routes to #update" do
      put("/reportings_tanimotos/1").should route_to("reportings_tanimotos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportings_tanimotos/1").should route_to("reportings_tanimotos#destroy", :id => "1")
    end

  end
end
