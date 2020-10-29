module Paychex
  class Client
    module Workers
      # Get a list of the workers of the company
      def workers(company_id, options = {})
        get("companies/#{company_id}/workers", options)
      end
    end
  end
end
