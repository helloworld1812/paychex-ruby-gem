RSpec.describe 'Paychex' do
  describe 'organizations' do
    it 'should return a list' do
      company_id = 'WWEMHMFU'
      stub_get("companies/#{company_id}/organizations").to_return(
        body: fixture('organizations/organizations.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.organizations(company_id)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 2
      expect(response.body['metadata']['contentItemCount']).to be 2
    end

    it 'should return a specific organizations' do
      company_id = 'WWEMHMFU'
      organization_id = '10406898'
      stub_get("companies/#{company_id}/organizations/#{organization_id}").to_return(
        body: fixture('organizations/organization.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.organization(company_id, organization_id)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 1
      expect(response.body['content'][0]['organizationId']).to eq organization_id
    end
  end
end
