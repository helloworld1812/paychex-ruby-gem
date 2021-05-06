module Paychex
  class Client
    module JobTitles
      # Get a list of the job titles for a company
      def job_titles(company_id)
        get("companies/#{company_id}/jobtitles")
      end

      # Get a specific job title's details
      def job_title(company_id, job_title_id)
        get("companies/#{company_id}/jobtitles/#{job_title_id}")
      end
    end
  end
end
