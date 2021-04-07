module Paychex
  class Client
    module Workers
      # Get a list of the workers of the company
      def workers(company_id, options = {})
        get("companies/#{company_id}/workers", options)
      end

      # Get a specific worker's profile
      def worker(worker_id, options = {})
        get("workers/#{worker_id}", options)
      end

      # Create a worker
      def create_worker(company_id, options = {})
        post("companies/#{company_id}/workers", options)
      end

      def remove_worker(worker_id, options = {})
        delete("workers/#{worker_id}", options)
      end
    end
  end
end
