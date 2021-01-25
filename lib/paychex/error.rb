module Paychex
  # Custom error class for rescuing from all paychex errors
  class Error < StandardError
    attr_reader :http_method, :url, :errors, :response, :raw_errors

    def initialize(response)
      super
      @response = response.dup
      @http_method = response.method.to_s
      @url = response.url
      @raw_errors = response.body.fetch('errors') if response.body.is_a?(Hash) && !response.body.empty? && !response.body.fetch('errors', nil).nil?
    end

    def message
      <<-HEREDOC
        URL: #{@response.url}
        method: #{@response.method}
        response status: #{@response.status}
        response body: #{@response.response.body}
      HEREDOC
    end

    def error_sentence
      return if @raw_errors.nil?

      array = []
      @raw_errors.each do |v|
        array += "#{v['code']}: #{v['description']}, #{v['resolution']}"
      end

      array.join(' ')
    end
  end

  # Raised when api.paychex.com returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when api.paychex.com returns the HTTP status code 401
  class Unauthorized < Error; end

  # Raised when api.paychex.com returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when api.paychex.com returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when api.paychex.com returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when api.paychex.com returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when api.paychex.com returns the HTTP status code 504
  class GatewayTimeout < Error; end

  # Raised when client fails to provide required parameters.
  class MissingRequiredArgument < Error; end
end
