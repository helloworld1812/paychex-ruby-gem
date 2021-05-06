RSpec.describe "Paychex" do
  describe "job titles" do
    it "should return a list" do
      company_id = "WWEMHMFU"
      stub_get("companies/#{company_id}/jobtitles").to_return(
        :body => fixture("job_titles/job_titles.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.job_titles(company_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 2
      expect(response.body["metadata"]["contentItemCount"]).to be 2
    end

    it "should return a specific job title" do
      company_id = "WWEMHMFU"
      job_title_id = "87186920"
      stub_get("companies/#{company_id}/jobtitles/#{job_title_id}").to_return(
        :body => fixture("job_titles/job_title.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      client.access_token = "211fe7540e"
      response = client.job_title(company_id, job_title_id)
      expect(response.status).to eq(200)
      expect(response.body["content"].count).to be 1
      expect(response.body["content"][0]["jobTitleId"]).to eq job_title_id
    end
  end
end
