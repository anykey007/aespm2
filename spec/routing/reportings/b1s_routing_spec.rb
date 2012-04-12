require "spec_helper"

describe Reportings::B1sController do
  describe "routing" do

    it "routes to #index" do
      get("/reportings_b1s").should route_to("reportings_b1s#index")
    end

    it "routes to #new" do
      get("/reportings_b1s/new").should route_to("reportings_b1s#new")
    end

    it "routes to #show" do
      get("/reportings_b1s/1").should route_to("reportings_b1s#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reportings_b1s/1/edit").should route_to("reportings_b1s#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reportings_b1s").should route_to("reportings_b1s#create")
    end

    it "routes to #update" do
      put("/reportings_b1s/1").should route_to("reportings_b1s#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reportings_b1s/1").should route_to("reportings_b1s#destroy", :id => "1")
    end

  end
end
