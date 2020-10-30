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
end
