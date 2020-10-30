module Paychex
  class Client
    module LaborAssignments
      # Get a list of the labor assignments for a company
      def labor_assignments(company_id)
        get("companies/#{company_id}/laborassignments")
      end

      # Get a specific labor assignment's details
      def labor_assignment(company_id, labor_assignment_id)
        get("companies/#{company_id}/laborassignments/#{labor_assignment_id}")
      end
    end
  end
end
