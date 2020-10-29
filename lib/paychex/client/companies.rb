module Paychex
  class Client
    module Companies
      # Get a list of all the linked companies
      def linked_companies(options = {})
        get("companies", options)
      end
    end
  end
end
