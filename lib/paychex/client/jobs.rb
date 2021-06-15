module Paychex
  class Client
    module Jobs
      # Get a list of the jobs for a company
      def jobs(company_id)
        get("companies/#{company_id}/jobs")
      end

      # Get a specific job's details
      def job(company_id, job_id)
        get("companies/#{company_id}/jobs/#{job_id}")
      end
    end
  end
end
