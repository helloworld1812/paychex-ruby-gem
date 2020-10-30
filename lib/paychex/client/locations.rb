module Paychex
  class Client
    module Locations
      # Get a list of the locations for a company
      def locations(company_id, options = {})
        get("companies/#{company_id}/locations")
      end

      # Get a specific location's details
      def location(company_id, location_id, options = {})
        get("companies/#{company_id}/locations/#{location_id}")
      end
    end
  end
end
