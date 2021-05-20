module Paychex
  class Client
    module Organizations
      # Get a list of the organizations for a company
      def organizations(company_id)
        get("companies/#{company_id}/organizations")
      end

      # Get a specific organization's details
      def organization(company_id, organization_id)
        get("companies/#{company_id}/organizations/#{organization_id}")
      end
    end
  end
end
