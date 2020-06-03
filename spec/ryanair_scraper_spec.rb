# frozen_string_literal: true

require './src/ryanair_scraper'
require 'spec_helper'

RSpec.describe RyanairScraper do
  it 'returns a successful response' do
    scraper = RyanairScraper.new(
      date_out: '2020-07-01',
      origin: 'AGP',
      destination: 'BLQ'
    )

    response = scraper.call

    expect(response).to be_an_instance_of(Hash)
  end
end
