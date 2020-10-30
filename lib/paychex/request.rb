require "base64"

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
      request(:post, path, {}, options)
    end

    private

    def request(method, path, options, post_options = nil)
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(URI.encode(path), options)
        when :post, :put
          if post_options.nil?
            request.path = URI.encode(path)
          else
            request.url(URI.encode(path), post_options)
          end
          request.body = options
        end
      end

      response
    end
  end
end
