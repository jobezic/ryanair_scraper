# frozen_string_literal: true

require 'webmock/rspec'
require 'json'
require './lib/constants'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    fake_response_one_way = File.open 'spec/fake_response_one_way.json'
    stub_request(:get, /#{API_HOST}.+RoundTrip=false/).with(
      headers: { 'Accept': '*/*', 'User-Agent': 'Ruby' }
    ).to_return(
      status: 200, body: fake_response_one_way, headers: {}
    )

    fake_response_round_trip = File.open 'spec/fake_response_round_trip.json'
    stub_request(:get, /#{API_HOST}.+RoundTrip=true/).with(
      headers: { 'Accept': '*/*', 'User-Agent': 'Ruby' }
    ).to_return(
      status: 200, body: fake_response_round_trip, headers: {}
    )
  end
end
