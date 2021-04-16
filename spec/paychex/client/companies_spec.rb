RSpec.describe 'Paychex' do
  describe 'linked companies' do
    it 'should return list' do
      stub_get('companies').to_return(
        body: fixture('companies/companies.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.linked_companies
      expect(response.status).to eq(200)
      expect(response.body['metadata']['contentItemCount']).to be 1
      expect(response.body['content'].count).to be 1
    end

    it 'should return a specific company profile' do
      company_id = 'WWEMHMFU'
      stub_get("companies/#{company_id}").to_return(
        body: fixture('companies/company.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.linked_company(company_id)
      expect(response.status).to eq(200)
      expect(response.body['metadata']).to be nil
      expect(response.body['content'].count).to be 1
      expect(response.body['links'].count).to be 0
    end

    it 'should verify access to company' do
      company_id = 'WWEMHMFU'
      stub_get("companies/#{company_id}").to_return(
        body: fixture('companies/company.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.company_status(company_id)
      expect(response).to eq('linked')
    end

    it 'should fail verification of company access' do
      company_id = 'WWFUXTES'
      stub_get("companies/#{company_id}").to_return(
        body: fixture('companies/company_no_access.json'),
        headers: {
          content_type: 'application/json; charset=utf-8'
        },
        status: 403
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.company_status(company_id)
      expect(response).to eq('not-linked')
    end

    it 'should fail access to invalid company' do
      company_id = 'WWFU'
      stub_get("companies/#{company_id}").to_return(
        body: fixture('companies/invalid_company.json'),
        headers: {
          content_type: 'application/json; charset=utf-8'
        },
        status: 404
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.company_status(company_id)
      expect(response).to eq('invalid')
    end
  end
end
