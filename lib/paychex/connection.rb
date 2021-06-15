require 'faraday_middleware'
require 'faraday/raise_paychex_http_exception'

module Paychex
  module Connection
    private

    def connection
      options = {
        headers: {
          'Accept' => "application/#{format}; charset=utf-8",
          'User-Agent' => user_agent
        },
        proxy: proxy,
        url: endpoint
      }.merge(connection_options)

      Faraday::Connection.new(options) do |conn|
        conn.authorization :Bearer, access_token unless access_token.nil?
        # https://github.com/lostisland/faraday/issues/417#issuecomment-223413386
        conn.options[:timeout] = timeout
        conn.options[:open_timeout] = open_timeout
        conn.request :json

        conn.use ::PaychexFaradayMiddleWare::RaisePaychexHttpException
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
