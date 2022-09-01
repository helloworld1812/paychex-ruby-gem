RSpec.describe 'Paychex' do
  describe 'workers' do
    it 'should return a list' do
      company_id = 'WWEMHMFU'
      stub_get("companies/#{company_id}/workers").to_return(
        body: fixture('workers/workers.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.workers(company_id)
      expect(response.status).to eq(200)
      expect(response.body['metadata']['contentItemCount']).to be 2
      expect(response.body['content'].count).to be 2
    end

    it 'should return a specific worker' do
      worker_id = '0EK1BK2AB3ZF'
      stub_get("workers/#{worker_id}").to_return(
        body: fixture('workers/worker.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.worker(worker_id)
      expect(response.status).to eq(200)
      expect(response.body['metadata']).to be nil
      expect(response.body['content'].count).to be 1
      expect(response.body['links'].count).to be 0
    end

    it 'should create a worker with minimal info' do
      company_id = 'WWEMHMFU'
      stub_post("companies/#{company_id}/workers").to_return(
        body: fixture('workers/workers_create.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      data = [{
        "workerType": 'EMPLOYEE',
        "name": {
          "familyName": 'Blast',
          "givenName": 'Futo'
        }
      }]
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.create_worker(company_id, data)
      expect(response.status).to eq(200)
      expect(response.body['metadata']).to be nil
      expect(response.body['content'].count).to be 1
      expect(response.body['links'].count).to be 0
    end

    it 'should validate a worker_id for a company' do
      company_id = 'WWEMHMFU'
      worker_id = '00CMD5KR2BO1T'
      stub_get("companies/#{company_id}/workers").to_return(
        body: fixture('workers/workers.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      status = client.worker_status(company_id, worker_id)
      expect(status).to eq('valid')
    end

    it 'should not be able to validate a worker_id for a company' do
      company_id = 'WWEMHMFU'
      worker_id = '00JWDG8ZL8QJC0'
      stub_get("companies/#{company_id}/workers").to_return(
        body: fixture('workers/workers.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      status = client.worker_status(company_id, worker_id)
      expect(status).not_to eq('valid')
    end
    
    it 'should create_worker_contacts' do
      worker_id = '00JWDG8ZL8QJC0'
      stub_get("workers/#{worker_id}/contacts").to_return(
        body: fixture('workers/workers_contact.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      data = [
        {
          "contactType": {
            "contactTypeId": "82450"
          },
          "relationship": {
            "relationshipType": {
              "relationshipTypeId": "458810"
            },
            "primary": false,
            "person": {
              "name": {
                "familyName": "Attridge",
                "givenName": "Mike"
              },
              "communication": {
                "telecom": [
                  {
                    "dialCountry": "1",
                    "dialArea": "585",
                    "dialNumber": "5552222",
                    "type": "PHONE",
                    "usageType": "PERSONAL"
                  }
                ],
                "postal": [
                  {
                    "postOfficeBox": "123 Main St",
                    "city": "Rochester",
                    "postalCode": "123456",
                    "countrySubdivisionCode": "NY",
                    "countryCode": "US"
                  }
                ],
                "email": [
                  {
                    "uri": "fake@test.com",
                    "usageType": "PERSONAL"
                  }
                ]
              }
            }
          }
        }
      ]
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.create_worker_contacts(worker_id, data)
      expect(response.status).to eq(200)
    end
  end
end
