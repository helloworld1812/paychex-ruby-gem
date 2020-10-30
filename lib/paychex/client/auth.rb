module Paychex
  class Client
    module Auth
      # Authorize a client and get back a access token with expiry.
      # TODO: Use application/x-www-form-urlencoded as content-type
      # and stop using query parameters in post message
      def authorize(options = {})
        response = auth("auth/oauth/v2/token", options)
        if response.body.is_a?(Hash) && response.body["access_token"]
          self.access_token = response.body["access_token"]
          self.token_timeout = Time.new + response.body["expires_in"]
          return response
        else
          # raise error when token is missing.
          raise Paychex::BadRequest.new(response)
        end
      end
    end
  end
end
