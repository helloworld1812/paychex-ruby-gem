RSpec.describe "Paychex" do
  describe "jobs" do
    it "should return a list" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}/jobs").to_return(
        :body => fixture("jobs/jobs.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.jobs(company_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 2
    end

    it "should return a specific job" do
      company_id = "WWEMHMFU"
      job_id = "0EK1BK2AB3ZF"
      stub_get("companies/#{company_id}/jobs/#{job_id}").to_return(
        :body => fixture("jobs/job.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.job(company_id, job_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 1
    end
  end
end
