require "faraday"

module FaradayMiddleWare
  class RaiseHttpException < Faraday::Middleware
    def initialize(app)
      super(app)
    end

    def call(env)
      @app.call(env).on_complete do |response|
        case response.status.to_i
        when 400
          raise Paychex::BadRequest.new(response)
        when 401
          raise Paychex::Unauthorized.new(response)
        when 404
          raise Paychex::NotFound.new(response)
        when 500
          raise Paychex::InternalServerError.new(response)
        when 502
          raise Paychex::BadGateway.new(response)
        when 503
          raise Paychex::ServiceUnavailable.new(response)
        when 504
          raise Paychex::GatewayTimeout.new(response)
        end
      end
    end
  end
end
