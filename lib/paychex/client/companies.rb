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

      def is_company_linked?(company_id)
        content = linked_company(company_id).body.fetch('content')
        content[0]&.fetch('companyId') == company_id
      rescue StandardError => e
        false
      end
    end
  end
end
