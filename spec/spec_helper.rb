require 'webmock/rspec'
require 'json'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    fake_response = File.open 'spec/fake_response.json'
    stub_request(:get, /www.ryanair.com/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: fake_response, headers: {})
  end
end
