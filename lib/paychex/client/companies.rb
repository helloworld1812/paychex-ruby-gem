module Paychex
  class Client
    module Companies
      # Get a list of all the linked companies
      # This will be unavailable once we have 200+ linked companies
      def linked_companies
        get('companies')
      end

      # Get profile of a linked company
      def linked_company(company_id)
        get("companies/#{company_id}")
      end

      # Get company contact types
      def company_contact_types(company_id)
        get("companies/#{company_id}/contacttypes")
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
          content = get("companies?displayId=#{display_id}").body.fetch('content')
          company = content[0]
          return {
            "company": company,
            "message": 'found'
          }
        rescue Paychex::NotFound => e
          return {
            "company": nil,
            "message": 'not found'
          }
        rescue Paychex::NoAccess => e
          return {
            "company": nil,
            "message": 'not found'
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

      def details_by_display_ids(display_ids)
        ret = {}
        begin
          display_ids.each do |display_id|
            content = details_by_display_id(display_id)
            company = content[:company]
            ret[display_id.to_s] = {
              "company": company,
              "message": company.nil? ? 'not-found' : 'found'
            }
          end
          return ret
        rescue Paychex::NoAccess => e
          ret['message'] = 'unknown'
          return ret
        rescue StandardError => e
          p 'Paychex Gem: Handle more errors'
          p e
        end
        ret['message'] = 'unsupported'
        ret
      end
    end
  end
end
