module Paychex
  class Client
    module Companies
      # Get a list of all the linked companies
      def linked_companies()
        get("companies")
      end
      end
    end
  end
end
