require "spec_helper"

describe Reportings::BalancesController do
  describe "routing" do

    it "routes to #index" do
      get("/reportings/balances").should route_to("reportings/balances#index")
    end

    it "routes to #new" do
      get("/reportings/balances/new").should route_to("reportings/balances#new")
    end

    it "routes to #show" do
      get("/reportings/balances/1").should route_to("reportings/balances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportings/balances/1/edit").should route_to("reportings/balances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportings/balances").should route_to("reportings/balances#create")
    end

    it "routes to #update" do
      put("/reportings/balances/1").should route_to("reportings/balances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportings/balances/1").should route_to("reportings/balances#destroy", :id => "1")
    end

  end
end
