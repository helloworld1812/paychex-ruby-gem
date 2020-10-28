require "paychex/connection"
require "paychex/request"
require "paychex/configuration"

module Paychex
  class API
    include Connection
    include Request

    attr_accessor *Paychex::Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options = {})
      options = Paychex.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end
  end
end
