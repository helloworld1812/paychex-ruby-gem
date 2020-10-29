RSpec.describe "Paychex" do
  describe "workers" do
    it "should return a list" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}/workers").to_return(
        :body => fixture("workers.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.workers(company_id)
      expect(response.status).to eq(200)
      expect(response.body["metadata"]["contentItemCount"]).to be 2
      expect(response.body["content"].count).to be 2
    end

    it "should return a single worker" do
      worker_id = "0EK1BK2AB3ZF"
      stub_get("workers/#{worker_id}").to_return(
        :body => fixture("worker.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.worker(worker_id)
      expect(response.status).to eq(200)
      expect(response.body["metadata"]).to be nil
      expect(response.body["content"].count).to be 1
      expect(response.body["links"].count).to be 0
    end
  end
end
