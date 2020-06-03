# frozen_string_literal: true

require 'net/http'
require 'json'
require './src/constants'

class RyanairScraper
  def initialize(date_in: '', date_out:, origin:, destination:, round_trip: false)
    @date_in = date_in
    @date_out = date_out
    @origin = origin
    @destination = destination
    @round_trip = round_trip
  end

  def call
    @data = do_request_to_api
    extract_data
  end

  private

  def do_request_to_api
    base_uri = "https://#{API_HOST}/api/booking/v4/es-es/availability"
    # TODO: compose the url by parameters in a better way + parametrize all
    uri = URI("#{base_uri}?ADT=1&CHD=0&DateIn=#{@date_in}&DateOut=#{@date_out}&Destination=#{@destination}&Disc=0&INF=0&Origin=#{@origin}&TEEN=0&FlexDaysIn=2&FlexDaysBeforeIn=2&FlexDaysOut=2&FlexDaysBeforeOut=2&ToUs=AGREED&IncludeConnectingFlights=false&RoundTrip=#{@round_trip}")
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri

      response = http.request request
      JSON.parse response.body
    end
  end

  def extract_data
    return if @data['trips'].empty?

    # probably we have more trips if choose a round trip route
    trip = @data['trips'].first
    {
      origin: trip['origin'],
      destination: trip['destination'],
      dates: extract_dates_info(trip['dates'])
    }
  end

  def extract_dates_info(dates)
    return [] if dates.nil? || dates.empty?

    dates.map do |date|
      # we can have more flights for the same date
      extract_flights_info(date['flights'])
    end
  end

  def extract_flights_info(flights)
    return if flights.empty?

    flights.map do |flight|
      {
        fares_left: flight['faresLeft'],
        fares: extract_fares_info(flight['regularFare']['fares'])
      }
    end
  end

  def extract_fares_info(fares)
    fares.map do |fare|
      {
        amount: fare['amount']
      }
    end
  end
end
