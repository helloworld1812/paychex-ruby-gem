module Paychex
  class Client
    module Companies
      # Get a list of all the linked companies
      def linked_companies
        get('companies')
      end

      # Get profile of a linked company
      def linked_company(company_id)
        get("companies/#{company_id}")
      end
    end
  end
end
