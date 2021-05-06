require 'paychex/api'

module Paychex
  # Wrapper for the Paychex REST API
  #
  # @note All methods have been separated into modules for better management.
  # @see https://developer.paychex.com/api-documentation-and-exploration/api-references
  class Client < Paychex::API
    require 'paychex/client/auth'
    require 'paychex/client/companies'
    require 'paychex/client/workers'
    require 'paychex/client/jobs'
    require 'paychex/client/job_titles'
    require 'paychex/client/locations'
    require 'paychex/client/labor_assignments'
    require 'paychex/client/pay_rates'
    require 'paychex/client/federal_tax'
    require 'paychex/client/direct_deposit'

    include Paychex::Client::Auth
    include Paychex::Client::Companies
    include Paychex::Client::Workers
    include Paychex::Client::Jobs
    include Paychex::Client::JobTitles
    include Paychex::Client::Locations
    include Paychex::Client::LaborAssignments
    include Paychex::Client::PayRates
    include Paychex::Client::FederalTax
    include Paychex::Client::DirectDeposit

    attr_accessor :token_timeout
  end
end
