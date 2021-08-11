RSpec.describe 'Paychex' do
  describe 'companies' do
    it 'linked_companies should return list' do
      stub_get('companies').to_return(
        body: fixture('companies/companies.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.linked_companies
      expect(response.status).to eq(200)
      expect(response.body['metadata']['contentItemCount']).to be 2
      expect(response.body['content'].count).to be 2
    end

    it 'linked_company should return a specific company profile' do
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

    it 'company_status should verify access to company' do
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

    it 'company_status should fail verification of company access' do
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

    it 'company_status should fail access to invalid company' do
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

    it 'details_by_display_id should fetch company details via display id' do
      display_id = '62725201'
      stub_get('companies').to_return(
        body: fixture('companies/companies.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.details_by_display_id(display_id)
      expect(response[:message]).to eq('found')
      expect(response[:company].fetch('displayId')).to eq(display_id)
    end

    it 'details_by_display_id should fetch company details via display id' do
      display_id = '62725701'
      stub_get('companies').to_return(
        body: fixture('companies/companies.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.details_by_display_id(display_id)
      expect(response[:message]).to eq('not-found')
      expect(response[:company]).to be_falsey
    end

    it 'details_by_display_ids should fetch company details via all display ids' do
      display_ids = %w[62725201 98771491 98551491]
      stub_get('companies').to_return(
        body: fixture('companies/companies.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.details_by_display_ids(display_ids)
      expect(response['62725201'][:message]).to eq('found')
      expect(response['62725201'][:company].fetch('displayId')).to eq('62725201')
      expect(response['98771491'][:message]).to eq('found')
      expect(response['98771491'][:company].fetch('displayId')).to eq('98771491')
      expect(response['98551491'][:message]).to eq('not-found')
      expect(response['98551491'][:company]).to be nil
    end
  end
end
