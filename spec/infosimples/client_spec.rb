client   = Infosimples::Data::Client.new(SECRETS['token'])
service  = SECRETS['service']
args     = SECRETS['args']
automate_response = client.automate(service, args)
billing_response  = client.billing
pricing_response  = client.pricing

RSpec.describe Infosimples::Data::Client do
  describe '#automate' do
    it { expect(automate_response['code']).to eq Infosimples::Data::CODE[:single_result] }
    it { expect(automate_response).to have_key('code_message') }
    it { expect(automate_response['header']['service']).to eq service }
    it { expect(automate_response['header']).to have_key('parameters') }
    it { expect(automate_response['header']).to have_key('client') }
    it { expect(automate_response['header']).to have_key('token') }
    it { expect(automate_response['header']).to have_key('billable') }
    it { expect(automate_response['header']).to have_key('credits') }
    it { expect(automate_response['header']).to have_key('cache_hit') }
    it { expect(automate_response['header']).to have_key('elapsed_time_in_milliseconds') }
    it { expect(automate_response).to have_key('data') }
    it { expect(automate_response['receipt']).to have_key('sites_urls') }
  end

  describe '#billing' do
    it { expect(billing_response).to be_instance_of(Array) }
    it { expect(billing_response.sample).to have_key('name') }
    it { expect(billing_response.sample).to have_key('quantity') }
    it { expect(billing_response.sample).to have_key('credits') }
  end

  describe '#pricing' do
    it { expect(pricing_response).to be_instance_of(Array) }
    it { expect(pricing_response.sample).to have_key('service') }
    it { expect(pricing_response.sample).to have_key('credits') }
  end
end
