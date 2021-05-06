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

      # Get company's linked status
      def worker_status(company_id, worker_id)
        begin
          content = workers(company_id).body.fetch('content')
          return 'valid' if content.one?{ |worker| worker.fetch('workerId') == worker_id }
        rescue Paychex::NoAccess => e
          return 'not-linked'
        rescue Paychex::NotFound => e
          return 'invalid'
        rescue StandardError => e
          p 'Paychex Gem: Handle more errors'
          p e
        end
        'unsupported'
      end
    end
  end
end
