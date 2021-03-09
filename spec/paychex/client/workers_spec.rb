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
  end
end
