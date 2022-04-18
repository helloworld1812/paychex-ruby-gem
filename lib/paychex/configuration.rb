require "paychex/version"

module Paychex
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Paychex::API}
    VALID_OPTIONS_KEYS = [
      :access_token,
      :host,
      :endpoint,
      :format,
      :connection_options,
      :proxy,
      :environment,
      :user_agent,
      :per_page,
      :timeout,
      :open_timeout,
      :token_timeout,
    ].freeze

    # By default, don't set an access_token
    DEFAULT_ACCESS_TOKEN = nil

    # By default, return 20 resources per page when there is an pagination.
    DEFAULT_PER_PAGE = 20

    # By default, don't set connection options.
    DEFAULT_CONNECTION_OPTIONS = {}

    # Default timeout time is 20 seconds
    DEFAULT_TIMEOUT = 20

    # By default, the open timeout is 20 seconds.
    DEFAULT_OPEN_TIMEOUT = 20

    DEFAULT_TOKEN_TIMEOUT = Time.new

    # By default, use sandbox environment
    DEFAULT_HOST = "https://sandbox.api.paychex.com".freeze

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = "https://sandbox.api.paychex.com/".freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, environment will be sandbox
    DEFAULT_ENVIRONMENT = "sandbox"

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Paychex Ruby Gem #{Paychex::VERSION}".freeze

    # An array of valid request/response formats
    VALID_FORMATS = [:json].freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token = DEFAULT_ACCESS_TOKEN
      self.host = DEFAULT_HOST
      self.endpoint = DEFAULT_ENDPOINT
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.format = DEFAULT_FORMAT
      self.proxy = DEFAULT_PROXY
      self.environment = DEFAULT_ENVIRONMENT
      self.user_agent = DEFAULT_USER_AGENT
      self.per_page = DEFAULT_PER_PAGE
      self.timeout = DEFAULT_TIMEOUT
      self.open_timeout = DEFAULT_OPEN_TIMEOUT
      self.token_timeout = DEFAULT_TOKEN_TIMEOUT
    end
  end
end
