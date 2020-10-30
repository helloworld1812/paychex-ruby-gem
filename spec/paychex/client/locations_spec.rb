RSpec.describe "Paychex" do
  describe "locations" do
    it "should return a list" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}/locations").to_return(
        :body => fixture("locations/locations.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.locations(company_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 3
    end

    it "should return a specific location" do
      company_id = "WWEMHMFU"
      location_id = "0EK1BK2AB3ZF"
      stub_get("companies/#{company_id}/locations/#{location_id}").to_return(
        :body => fixture("locations/location.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.location(company_id, location_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 1
    end
  end
end
