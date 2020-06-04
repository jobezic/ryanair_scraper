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

    it 'returns a response containing an origin, a destination and dates' do
      response = command.call

      expect(response.keys).to eq %i[
        origin
        destination
        dates
      ]
    end

    it 'returns valid flights for the specific origin, destination and date' do
      response = command.call

      expect(response).to eq(
        origin: 'AGP',
        destination: 'BLQ',
        dates: [
          {
            date_out: '2020-07-01T00:00:00.000',
            flights: [{ fares_left: 2, fares: [{ amount: 65.99 }] }]
          },
          {
            date_out: '2020-07-03T00:00:00.000',
            flights: [{ fares_left: 2, fares: [{ amount: 75.99 }] }]
          }
        ]
      )
    end
  end
end
