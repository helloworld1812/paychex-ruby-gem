RSpec.describe "Paychex auth to" do
  describe "get auth token with some expiry using client id and secret" do
    it "should return auth token" do
      stub_post(
        "auth/oauth/v2/token?client_id=c22&client_secret=8f6a4213&grant_type=client_credentials"
      ).to_return(
        :body => fixture("auth.json"),
        :headers => { :content_type => "application/json; charset=utf-8" },
      )
      client = Paychex.client()
      response = client.authorize({
        grant_type: "client_credentials",
        client_id: "c22",
        client_secret: "8f6a4213",
      })
      expect(response.status).to eq(200)
      expect(response.body["access_token"]).to eq("211fe7540e")
      expect(client.access_token).to eq(response.body["access_token"])
      expect(response.body["expires_in"]).to be 3600
    end
  end
end
