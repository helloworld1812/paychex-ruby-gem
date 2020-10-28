require "byebug"

RSpec.describe Paychex do
  it "has a version number" do
    expect(Paychex::VERSION).not_to be nil
  end

  it "has required options to configure" do
    options = ["access_token", "host", "environment"]
    options.each do |option|
      expect(Paychex.methods.include?("#{option}=".to_sym)).to eq(true)
    end
  end

  describe ".access_token," do
    it "should be nil by default" do
      expect(Paychex.access_token).to eq(nil)
    end
  end

  describe ".endpoint" do
    it "should be https://sandbox.api.paychex.com/" do
      expect(Paychex.endpoint).to eq("https://sandbox.api.paychex.com/")
    end
  end

  describe ".auto_paginate" do
    it "should enable auto_paginate by default" do
      expect(Paychex.auto_paginate).to eq(true)
    end
  end

  describe ".per_page" do
    it "should be 20 by default" do
      expect(Paychex.per_page).to eq(20)
    end
  end

  describe ".format" do
    it "should be json" do
      expect(Paychex.format).to eq(:json)
    end
  end

  describe "get auth token with some expirt using client id and secret" do
    it "should return auth token" do
      client = Paychex.client()
      response = client.authorize({
        grant_type: "client_credentials",
        client_id: "client_id",
        client_secret: "client_secret",
      })
      expect(response.status).to eq(200)
      expect(response.body["access_token"]).not_to eq(nil)
      expect(response.body["expires_in"]).to be > 0
    end
  end
end
