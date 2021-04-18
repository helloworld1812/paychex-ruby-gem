require 'faraday'

module PaychexFaradayMiddleWare
  class RaisePaychexHttpException < Faraday::Middleware
    def initialize(app)
      super(app)
    end

    def call(env)
      @app.call(env).on_complete do |response|
        case response.status.to_i
        when 400
          raise Paychex::BadRequest, response
        when 401
          raise Paychex::Unauthorized, response
        when 403
          raise Paychex::NoAccess, response
        when 404
          raise Paychex::NotFound, response
        when 500
          raise Paychex::InternalServerError, response
        when 502
          raise Paychex::BadGateway, response
        when 503
          raise Paychex::ServiceUnavailable, response
        when 504
          raise Paychex::GatewayTimeout, response
        end
      end
    end
  end
end
