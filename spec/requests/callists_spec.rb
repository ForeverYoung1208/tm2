require 'rails_helper'

RSpec.describe "Callists", :type => :request do
  describe "GET /callists" do
    it "works! (now write some real specs)" do
      get callists_path
      expect(response).to have_http_status(200)
    end
  end
end
