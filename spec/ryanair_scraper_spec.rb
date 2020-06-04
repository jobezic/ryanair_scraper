# frozen_string_literal: true

require './src/ryanair_scraper'
require 'spec_helper'

RSpec.describe RyanairScraper do
  context 'one way' do
    let(:round_trip) { false }

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

        expect(response).to be_an_instance_of(Array)
      end

      it 'returns a single trip' do
        response = command.call

        expect(response.length).to eq(1)
      end

      it 'returns a response containing an origin, a destination and dates' do
        response = command.call.first

        expect(response.keys).to eq %i[
          origin
          destination
          dates
        ]
      end

      it 'returns valid flights for the specific origin, destination and date' do
        response = command.call.first

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

  context 'round trip' do
    let(:round_trip) { true }

    context 'with an origin, a destination, a departure date and a return date' do
      let(:origin) { 'AGP' }
      let(:destination) { 'BLQ' }
      let(:date_out) { '2020-07-01' }
      let(:date_in) { '2020-07-03' }

      let(:command) do
        RyanairScraper.new(
          date_out: date_out,
          date_in: date_in,
          origin: origin,
          destination: destination,
          round_trip: round_trip
        )
      end

      it 'returns a successful response' do
        response = command.call

        expect(response).to be_an_instance_of(Array)
      end

      it 'returns a 2-way trip' do
        response = command.call

        expect(response.length).to eq(2)
      end

      it 'returns valid flights for the specific origin, destination and dates' do
        response = command.call.first

        expect(response).to eq(
          origin: 'AGP',
          destination: 'BLQ',
          dates: [
            {
              date_out: '2020-07-01T00:00:00.000',
              flights: [{ fares_left: -1, fares: [{ amount: 59.52 }] }]
            },
            {
              date_out: '2020-07-03T00:00:00.000',
              flights: [{ fares_left: 4, fares: [{ amount: 75.99 }] }]
            }
          ]
        )
      end
    end
  end
end
