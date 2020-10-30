require "paychex/api"

module Paychex
  # Wrapper for the Paychex REST API
  #
  # @note All methods have been separated into modules for better management.
  # @see https://developer.paychex.com/api-documentation-and-exploration/api-references
  class Client < Paychex::API
    require "paychex/client/auth"
    require "paychex/client/companies"
    require "paychex/client/workers"

    include Paychex::Client::Auth
    include Paychex::Client::Companies
    include Paychex::Client::Workers

    attr_accessor :token_timeout
  end
end
