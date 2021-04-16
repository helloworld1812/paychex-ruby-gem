require 'paychex/configuration'
require 'paychex/error'
require 'paychex/api'
require 'paychex/client'

module Paychex
  extend Configuration

  # Alias for Paychex::Client.new
  #
  # @return [Paychex::Client]
  def self.client(options = {})
    ::Paychex::Client.new(options)
  end

  # Delegate to Paychex::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end

  # Delegate to Paychex::Client
  def self.respond_to?(method, include_all = false)
    client.respond_to?(method, include_all) || super
  end
end
