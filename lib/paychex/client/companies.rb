module Paychex
  class Client
    module Companies
      # Get a list of all the linked companies
      def linked_companies
        limit = per_page
        opts = { limit: limit, offset: 0 }
        response_content = []
        current_page = 1

        response = companies(opts)

        begin
          while response && response.body
            companies_count = response.body.fetch('metadata').fetch('pagination').fetch('total')

            break unless companies_count

            no_of_pages = (companies_count.to_f / limit).ceil

            companies_content = response.body.fetch('content').to_a
            companies_content = companies_content.select { |c| c['hasPermission'] } if companies_content
            response_content += companies_content

            current_page += 1
            if current_page <= no_of_pages
              opts = { limit: limit, offset: (current_page - 1) * limit }
              response = companies(opts)
            else
              break
            end
          end
        rescue StandardError => e
          return response_content
        end

        response_content
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
          content = get("companies?displayid=#{display_id}").body.fetch('content')
          company = content[0]
          return {
            "company": company,
            "message": 'found'
          }
        rescue Paychex::NotFound => e
          return {
            "company": nil,
            "message": 'not-found'
          }
        rescue Paychex::NoAccess => e
          return {
            "company": nil,
            "message": 'not-found'
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

    private

    def companies(options)
      begin
        get('companies', options)
      rescue => e
        nil
      end
    end
  end
end
