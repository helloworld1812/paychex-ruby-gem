module Paychex
  class Client
    module DirectDeposit
      # Get a specific worker's direct deposit details
      def direct_deposit(worker_id)
        get("workers/#{worker_id}/directdeposits")
      end

      # Add a worker's direct deposit details
      def add_direct_deposit(worker_id, options = {})
        post("workers/#{worker_id}/directdeposits", options)
      end
    end
  end
end
