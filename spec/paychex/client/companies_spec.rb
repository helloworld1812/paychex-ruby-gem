RSpec.describe "Paychex" do
  describe "linked companies" do
    it "should return list" do
      stub_get("companies").to_return(
        :body => fixture("company_list.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.linked_companies()
      expect(response.status).to eq(200)
      expect(response.body["metadata"]["contentItemCount"]).to be 1
      expect(response.body["content"].count).to be 1
    end

    it "should return a single company profile" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}").to_return(
        :body => fixture("company.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.linked_company(company_id)
      expect(response.status).to eq(200)
      expect(response.body["metadata"]).to be nil
      expect(response.body["content"].count).to be 1
      expect(response.body["links"].count).to be 0
    end
  end
end
