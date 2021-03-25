RSpec.describe 'Paychex' do
  describe 'pay rates' do
    it 'should return a federal tax for a worker' do
      worker_id = 'WWEMHMFU'
      stub_get("workers/#{worker_id}/federaltax").to_return(
        body: fixture('federal_tax/federal_tax.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.federal_tax(worker_id)
      expect(response.status).to eq(200)
      expect(response.body['taxId']).not_to be_nil
    end

    it 'should add a federal tax for a worker' do
      worker_id = 'WWEMHMFU'
      stub_post("workers/#{worker_id}/federaltax").to_return(
        body: fixture('federal_tax/federal_tax_create.json'),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
      data = {
        "filingStatus": 'MARRIED_FILING_JOINTLY',
        "multipleJobs": 'false',
        "dependentsAmount": '123.45',
        "otherIncome": '23.45',
        "deductionsAmount": '2.45',
        "extraWithholdingAmount": '3.45',
        "taxesWithheld": 'true'
      }
      client = Paychex.client()
      client.access_token = '211fe7540e'
      response = client.add_federal_tax(worker_id, data)
      expect(response.status).to eq(200)
      expect(response.body['taxId']).to eq('18851387')
    end
  end
end
