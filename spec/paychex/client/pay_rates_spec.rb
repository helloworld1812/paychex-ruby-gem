RSpec.describe 'Paychex' do
  describe 'pay rates' do
    it 'should return a list' do
      worker_id = 'WWEMHMFU'
      stub_get("workers/#{worker_id}/compensation/payrates").to_return(
        body: fixture('pay_rates/pay_rates.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.pay_rates(worker_id)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 4
    end

    it 'should return a specific pay rate' do
      worker_id = 'WWEMHMFU'
      pay_rate_id = '54610138'
      stub_get("workers/#{worker_id}/compensation/payrates/#{pay_rate_id}").to_return(
        body: fixture('pay_rates/pay_rate.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.pay_rate(worker_id, pay_rate_id)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 1
    end

    it 'should add a pay rate for a worker' do
      worker_id = 'WWEMHMFU'
      stub_post("workers/#{worker_id}/compensation/payrates").to_return(
        body: fixture('pay_rates/pay_rate_create.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      data = {
        "rateNumber": 'RATE_1',
        "rateType": 'HOURLY_RATE',
        "amount": '40.20'
      }
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.add_pay_rate(worker_id, data)
      expect(response.status).to eq(200)
      expect(response.body['content'].count).to be 1
    end
  end
end
