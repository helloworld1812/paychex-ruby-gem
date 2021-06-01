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

      # Get company's linked status
      def company_status(company_id)
        begin
          content = linked_company(company_id).body.fetch('content')
          return 'linked' if content[0]&.fetch('companyId') == company_id
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

      def details_by_display_id(display_id)
        begin
          content = linked_companies.body.fetch('content')
          company = content.find { |company| company.fetch('displayId') == display_id }
          if company.nil?
            return {
              "company": company,
              "message": 'not-found'
            }
          else
            return {
              "company": company,
              "message": 'found'
            }
          end
        rescue Paychex::NoAccess => e
          return {
            "company": nil,
            "message": 'unknown'
          }
        rescue StandardError => e
          p 'Paychex Gem: Handle more errors'
          p e
        end
        {
          "company": nil,
          "message": 'unsupported'
        }
      end
    end
  end
end
