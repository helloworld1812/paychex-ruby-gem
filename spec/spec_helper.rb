require "bundler/setup"
require "paychex"
require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_delete(path)
  stub_request(:delete, Paychex.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Paychex.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Paychex.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Paychex.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end
