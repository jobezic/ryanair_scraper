# ryanair_scraper
Ryanair flights scraper

## API

How to call the api to receive info on a flight:

https://www.ryanair.com/api/booking/v4/es-es/availability?ADT=1&CHD=0&DateIn=&DateOut=2020-07-01&Destination=BLQ&Disc=0&INF=0&Origin=AGP&TEEN=0&FlexDaysIn=2&FlexDaysBeforeIn=2&FlexDaysOut=2&FlexDaysBeforeOut=2&ToUs=AGREED&IncludeConnectingFlights=false&RoundTrip=false

Here is how the response looks like:

```
{
  "termsOfUse": "https://www.ryanair.com/ie/en/corporate/terms-of-use=AGREED",
  "currency": "EUR",
  "currPrecision": 2,
  "routeGroup": "LEISURE",
  "tripType": "SUN_BREAK",
  "upgradeType": "PLUS",
  "trips": [
    {
      "origin": "AGP",
      "originName": "Málaga",
      "destination": "BLQ",
      "destinationName": "Bolonia",
      "routeGroup": "LEISURE",
      "tripType": "SUN_BREAK",
      "upgradeType": "PLUS",
      "dates": [
        {
          "dateOut": "2020-06-29T00:00:00.000",
          "flights": []
        },
        {
          "dateOut": "2020-06-30T00:00:00.000",
          "flights": []
        },
        {
          "dateOut": "2020-07-01T00:00:00.000",
          "flights": [
            {
              "faresLeft": 2,
              "flightKey": "FR~4602~ ~~AGP~07/01/2020 06:55~BLQ~07/01/2020 09:25~~",
              "infantsLeft": 18,
              "regularFare": {
                "fareKey": "ACIIUDZ7625JVGTPLH4OM3UVOOQDJ4FVXZ73WV6D6QCQXOPR5HFXYWWRRL5VVBTUMZGDBGNMYDDROOPKCOW3TE4GDWPGIZSKA5FQIQRXOTGP4A5NKUNH4OV2LX7K5III6UWDR6KSTOIL3ROVIFBADVH3QYJ2O2ECTUSBT5HD5SNXF5NAZ4KQ",
                "fareClass": "H",
                "fares": [
                  {
                    "type": "ADT",
                    "amount": 65.99,
                    "count": 1,
                    "hasDiscount": false,
                    "publishedFare": 65.99,
                    "discountInPercent": 0,
                    "hasPromoDiscount": false,
                    "discountAmount": 0
                  }
                ]
              },
              "operatedBy": "",
              "segments": [
                {
                  "segmentNr": 0,
                  "origin": "AGP",
                  "destination": "BLQ",
                  "flightNumber": "FR 4602",
                  "time": [
                    "2020-07-01T06:55:00.000",
                    "2020-07-01T09:25:00.000"
                  ],
                  "timeUTC": [
                    "2020-07-01T04:55:00.000Z",
                    "2020-07-01T07:25:00.000Z"
                  ],
                  "duration": "02:30"
                }
              ],
              "flightNumber": "FR 4602",
              "time": [
                "2020-07-01T06:55:00.000",
                "2020-07-01T09:25:00.000"
              ],
              "timeUTC": [
                "2020-07-01T04:55:00.000Z",
                "2020-07-01T07:25:00.000Z"
              ],
              "duration": "02:30"
            }
          ]
        },
        {
          "dateOut": "2020-07-02T00:00:00.000",
          "flights": []
        },
        {
          "dateOut": "2020-07-03T00:00:00.000",
          "flights": [
            {
              "faresLeft": 2,
              "flightKey": "FR~4602~ ~~AGP~07/03/2020 09:45~BLQ~07/03/2020 12:15~~",
              "infantsLeft": 17,
              "regularFare": {
                "fareKey": "VUMABVV62VJ4YX4KADIWW6AQMFICMOOI6YX4L5OCM7GIJDPCCKAQLRYHAX5CIXKOBTGJYABDOY4IGDO6EK7CXB3CJJ724F7K7BHEYZ2WAH4RLTUNNP2MN2HBMPFMPY6ASRHTNKRCKDACGE4ZGFKLLEHAFHBVN5DQB6VYVQGOHSZBLXIZDZLA",
                "fareClass": "C",
                "fares": [
                  {
                    "type": "ADT",
                    "amount": 75.99,
                    "count": 1,
                    "hasDiscount": false,
                    "publishedFare": 75.99,
                    "discountInPercent": 0,
                    "hasPromoDiscount": false,
                    "discountAmount": 0
                  }
                ]
              },
              "operatedBy": "Malta Air",
              "segments": [
                {
                  "segmentNr": 0,
                  "origin": "AGP",
                  "destination": "BLQ",
                  "flightNumber": "FR 4602",
                  "time": [
                    "2020-07-03T09:45:00.000",
                    "2020-07-03T12:15:00.000"
                  ],
                  "timeUTC": [
                    "2020-07-03T07:45:00.000Z",
                    "2020-07-03T10:15:00.000Z"
                  ],
                  "duration": "02:30"
                }
              ],
              "flightNumber": "FR 4602",
              "time": [
                "2020-07-03T09:45:00.000",
                "2020-07-03T12:15:00.000"
              ],
              "timeUTC": [
                "2020-07-03T07:45:00.000Z",
                "2020-07-03T10:15:00.000Z"
              ],
              "duration": "02:30"
            }
          ]
        }
      ]
    }
  ],
  "serverTimeUTC": "2020-06-01T11:14:47.488Z"
}
