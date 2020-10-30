RSpec.describe "Paychex" do
  describe "labor assignments" do
    it "should return a list" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}/laborassignments").to_return(
        :body => fixture("labor_assignments/labor_assignments.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.labor_assignments(company_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 4
    end

    it "should return a specific labor assignment" do
      company_id = "WWEMHMFU"
      labor_assignment_id = "0EK1BK2AB3ZF"
      stub_get("companies/#{company_id}/laborassignments/#{labor_assignment_id}").to_return(
        :body => fixture("labor_assignments/labor_assignment.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.labor_assignment(company_id, labor_assignment_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 1
    end
  end
end
