module Paychex
  class Client
    module Auth
      # Authorize a client and get back a access token with expiry.
      def authorize(options = {})
        response = auth('auth/oauth/v2/token', options)
        if response.body.is_a?(Hash) && response.body['access_token']
          self.access_token = response.body['access_token']
          self.token_timeout = Time.new + response.body['expires_in']
          response
        else
          # raise error when token is missing.
          raise Paychex::BadRequest, response
        end
      end

      # Indicates expiry of the auth token
      def token_expired?
        token_timeout < Time.new
      end
    end
  end
end
