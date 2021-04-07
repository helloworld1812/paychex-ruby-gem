RSpec.describe 'Paychex' do
  describe 'direct deposit' do
    it 'should return all direct deposit details for a worker' do
      worker_id = 'WWEMHMFU'
      stub_get("workers/#{worker_id}/directdeposits").to_return(
        body: fixture('direct_deposit/direct_deposit.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.direct_deposit(worker_id)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 2
    end

    it 'should add a direct deposit details for a worker' do
      worker_id = 'WWEMHMFU'
      stub_post("workers/#{worker_id}/directdeposits").to_return(
        body: fixture('direct_deposit/direct_deposit_create.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      data = {
        "paymentType": 'PERCENTAGE',
        "accountType": 'CHECKING',
        "value": 75,
        "routingNumber": '222371863',
        "accountNumber": '123456'
      }
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.add_direct_deposit(worker_id, data)
      expect(response.status).to eq(200)
      expect(response.body['content'][0]['directDepositId']).to eq('18851387')
    end
  end
end
