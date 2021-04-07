module Paychex
  class Client
    module DirectDeposit
      # Get the worker's all direct deposit details
      def direct_deposits(worker_id)
        get("workers/#{worker_id}/directdeposits")
      end

      # Get a worker's specific direct deposit details
      def direct_deposit(worker_id, direct_deposit_id)
        get("workers/#{worker_id}/directdeposits/#{direct_deposit_id}")
      end

      # Add a worker's direct deposit details
      def add_direct_deposit(worker_id, options = {})
        post("workers/#{worker_id}/directdeposits", options)
      end
    end
  end
end
