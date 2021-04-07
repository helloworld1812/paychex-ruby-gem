module Paychex
  class Client
    module PayRates
      # Get a list of compensation rates for a worker
      def pay_rates(worker_id)
        get("workers/#{worker_id}/compensation/payrates")
      end

      # Get a worker's specific compensation rate
      def pay_rate(worker_id, pay_rate_id)
        get("workers/#{worker_id}/compensation/payrates/#{pay_rate_id}")
      end

      # Add a worker's pay rate
      def add_pay_rate(worker_id, options = {})
        post("workers/#{worker_id}/compensation/payrates", options)
      end
    end
  end
end
