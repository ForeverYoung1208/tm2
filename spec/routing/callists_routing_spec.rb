require "rails_helper"

RSpec.describe CallistsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/callists").to route_to("callists#index")
    end

    it "routes to #new" do
      expect(:get => "/callists/new").to route_to("callists#new")
    end

    it "routes to #show" do
      expect(:get => "/callists/1").to route_to("callists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/callists/1/edit").to route_to("callists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/callists").to route_to("callists#create")
    end

    it "routes to #update" do
      expect(:put => "/callists/1").to route_to("callists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/callists/1").to route_to("callists#destroy", :id => "1")
    end

  end
end
