# frozen_string_literal: true

require 'net/http'
require 'json'
require './lib/constants'

class RyanairScraper
  def initialize(
    date_in: '',
    date_out:,
    origin:,
    destination:,
    round_trip: false,
    include_connecting_flights: false
  )
    @date_in = date_in
    @date_out = date_out
    @origin = origin
    @destination = destination
    @round_trip = round_trip
    @include_connecting_flights = include_connecting_flights
  end

  def call
    @data = do_request_to_api
    extract_data
  end

  private

  def do_request_to_api
    # TODO: parametrize all parameters + escape?
    uri = URI::HTTPS.build(
      host: API_HOST,
      path: '/api/booking/v4/es-es/availability',
      query: URI.encode_www_form(
        ADT: 1,
        CHD: 0,
        DateIn: @date_in,
        DateOut: @date_out,
        Origin: @origin,
        Destination: @destination,
        RoundTrip: @round_trip,
        IncludeConnectingFlights: @include_connecting_flights,
        Disc: 0,
        INF: 0,
        TEEN: 0,
        FlexDaysIn: 2,
        FlexDaysBeforeIn: 2,
        FlexDaysOut: 2,
        FlexDaysBeforeOut: 2,
        ToUs: 'AGREED'
      )
    )

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri

      response = http.request request
      JSON.parse response.body
    end
  end

  def extract_data
    return if @data['trips'].empty?

    @data['trips'].map do |trip|
      {
        origin: trip['origin'],
        destination: trip['destination'],
        dates: extract_dates_info(trip['dates'])
      }
    end
  end

  def extract_dates_info(dates)
    return [] if dates.nil? || dates.empty?

    dates.map do |date|
      next if date['flights'].empty?

      flights_info = extract_flights_info(date['flights'])
      next if flights_info.empty?

      # we can have more flights for the same date
      {
        date: date['dateOut'],
        flights: flights_info
      }
    end.compact
  end

  def extract_flights_info(flights)
    return if flights.empty?

    flights.map do |flight|
      # TODO: test the assumption that if faresLeft = 0 we don't have flight to buy
      # (keep in mind that if faresLeft is -1 the site shows flights to buy)
      next if flight['faresLeft'].zero?

      raise 'no regular fares left' if flight['regularFare'].nil?

      {
        # TODO: only regulare fare?
        fares: extract_fares_info(flight['regularFare']['fares']),
        duration: flight['duration'],
        flight_number: flight['flightNumber'],
        departure: flight['timeUTC'].first,
        arrival: flight['timeUTC'].last,
        layovers: extract_layovers(flight['segments'])
      }
    end.compact
  end

  def extract_fares_info(fares)
    fares.map { |fare| fare['amount'] }
  end

  def extract_layovers(segments)
    return if segments.nil?

    segments.map { |segment| segment['destination'] }.tap(&:pop)
  end
end
