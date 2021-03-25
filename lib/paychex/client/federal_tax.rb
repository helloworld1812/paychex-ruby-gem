module Paychex
  class Client
    module FederalTax
      # Get a specific worker's federal tax
      def federal_tax(worker_id)
        get("workers/#{worker_id}/federaltax")
      end

      # Add a worker's federal tax
      def add_federal_tax(worker_id, options = {})
        post("workers/#{worker_id}/federaltax", options)
      end
    end
  end
end
