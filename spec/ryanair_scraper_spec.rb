# frozen_string_literal: true

require './lib/ryanair_scraper'
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
              date: '2020-07-01',
              flights: [
                {
                  fares: [65.99],
                  layovers: [],
                  departure: '2020-07-01T04:55:00.000Z',
                  arrival: '2020-07-01T07:25:00.000Z',
                  duration: '02:30',
                  flight_number: 'FR 4602'
                }
              ]
            },
            {
              date: '2020-07-03',
              flights: [
                {
                  fares: [75.99],
                  layovers: [],
                  departure: '2020-07-03T07:45:00.000Z',
                  arrival: '2020-07-03T10:15:00.000Z',
                  duration: '02:30',
                  flight_number: 'FR 4602'
                }
              ]
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
        response = command.call

        expect(response).to eq(
          [
            {
              origin: 'AGP',
              destination: 'BLQ',
              dates: [
                {
                  date: '2020-07-01',
                  flights: [
                    {
                      fares: [59.52],
                      layovers: [],
                      departure: '2020-07-01T04:55:00.000Z',
                      arrival: '2020-07-01T07:25:00.000Z',
                      duration: '02:30',
                      flight_number: 'FR 4602'
                    }
                  ]
                },
                {
                  date: '2020-07-03',
                  flights: [
                    {
                      fares: [75.99],
                      layovers: [],
                      departure: '2020-07-03T07:45:00.000Z',
                      arrival: '2020-07-03T10:15:00.000Z',
                      duration: '02:30',
                      flight_number: 'FR 4602'
                    }
                  ]
                }
              ]
            },
            {
              origin: 'BLQ',
              destination: 'AGP',
              dates: [
                {
                  date: '2020-07-01',
                  flights: [
                    {
                      fares: [59.52],
                      layovers: [],
                      departure: '2020-07-01T07:55:00.000Z',
                      arrival: '2020-07-01T10:40:00.000Z',
                      duration: '02:45',
                      flight_number: 'FR 4601'
                    }
                  ]
                },
                {
                  date: '2020-07-03',
                  flights: [
                    {
                      fares: [49.62],
                      layovers: [],
                      departure: '2020-07-03T04:25:00.000Z',
                      arrival: '2020-07-03T07:10:00.000Z',
                      duration: '02:45',
                      flight_number: 'FR 4601'
                    }
                  ]
                }
              ]
            }
          ]
        )
      end
    end
  end

  context 'with layovers' do
    let(:origin) { 'BRI' }
    let(:destination) { 'BCN' }
    let(:date_out) { '2020-09-13' }
    let(:include_connecting_flights) { true }

    let(:command) do
      RyanairScraper.new(
        date_out: date_out,
        origin: origin,
        destination: destination,
        include_connecting_flights: include_connecting_flights
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

      expect(response).to eq(
        origin: 'BRI',
        destination: 'BCN',
        dates: [
          {
            date: '2020-09-08',
            flights: [
              {
                fares: [80.98],
                layovers: ['BGY'],
                departure: '2020-09-08T16:40:00.000Z',
                arrival: '2020-09-08T23:00:00.000Z',
                duration: '06:20',
                flight_number: 'FR 4705/FR 6366'
              }
            ]
          }
        ]
      )
    end
  end
end
