# frozen_string_literal: true

require './src/ryanair_scraper'
require 'spec_helper'

RSpec.describe RyanairScraper do
  context 'with an origin, a destination and a departure date' do
    let(:origin) { 'AGP' }
    let(:destination) { 'BLQ' }
    let(:date_out) { '2020-07-01' }

    let(:command) do
      RyanairScraper.new(
        date_out: date_out,
        origin: origin,
        destination: destination
      )
    end

    it 'returns a successful response' do
      response = command.call

      expect(response).to be_an_instance_of(Hash)
    end
  end
end
