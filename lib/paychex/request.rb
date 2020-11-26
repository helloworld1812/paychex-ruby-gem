require 'base64'

module Paychex
  # Defines HTTP request methods
  module Request
    # HTTP GET request
    def get(path, options = {})
      request(:get, path, options)
    end

    # HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    # HTTP PUT request
    def put(path, options = {})
      request(:put, path, options)
    end

    # HTTP DELETE request
    def delete(path, options = {})
      request(:delete, path, options)
    end

    def auth(path, options = {})
      request(:post, path, options)
    end

    private

    def request(method, path, options)
      # FIXME: replace URI.encode with something better, it is deprecated
      encoded_path = URI.encode(path)
      connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(encoded_path, options)
        # TODO: Need to test for more post and put requests
        when :post, :put
          request.path = encoded_path
          request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          request.body = URI.encode_www_form(options)
        end
      end
    end
  end
end
