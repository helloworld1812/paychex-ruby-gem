require 'uri'
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
      options['Content-Type'] = 'application/x-www-form-urlencoded'
      request(:post, path, options)
    end

    private

    def request(method, path, options)
      encoded_path = Addressable::URI.escape(path)
      connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(encoded_path, options)
        # TODO: Need to test for more post and put requests
        when :post, :put
          request.path = encoded_path
          content_type = options.delete('Content-Type')
          if content_type == 'application/x-www-form-urlencoded'
            request.headers['Content-Type'] = content_type
            request.body = URI.encode_www_form(options)
          else
            request.body = options
          end
        end
      end
    end
  end
end
