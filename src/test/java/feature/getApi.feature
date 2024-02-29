Feature: check all bookings by Api

  Background: 
    * url 'https://restful-booker.herokuapp.com/'
    * header Accept = 'application/json'

  Scenario: post new bookings
    Given path 'booking'
    And request
      """
      {
      "firstname" : "Komal",
      "lastname" : "Balkar",
      "totalprice" : 111,
      "depositpaid" : true,
      "bookingdates" : {
         "checkin" : "2018-01-01",
         "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
      }
      """
    When method POST
    Then status 200
    And print response
    And match $.booking.firstname == 'Komal'
    And match $.booking.lastname == 'Balkar'
    And match response.bookingid == '#present'
    * def id = response.bookingid

  Scenario: get all bookings
    Given path 'booking'
    When method GET
    Then status 200
    And print response

  Scenario: put old bookings
    Given path 'booking/710'
    And request
      """
      {
      "firstname" : "Advik",
      "lastname" : "Balkar",
      "totalprice" : 111,
      "depositpaid" : true,
      "bookingdates" : {
         "checkin" : "2018-01-01",
         "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
      }
      """
    And header Content-Type = 'application/json'
    And cookie token = 'abc123'
    When method PUT
    Then status 403
    And print response

  #And match $.booking.firstname == 'Advik'
  #And match $.booking.lastname == 'Balkar'
  Scenario: get bookings ID 1
    Given path 'booking/1'
    When method get
    Then status 200
    And print response

  Scenario: Update booking details
    Given path 'booking/1'
    When request
      """
      {
          "firstname": "James",
          "lastname": "Brown"
      }
      """
    And header Content-Type = 'application/json'
    And cookie token = 'abc123'
    When method PATCH
    Then status 403
    And print response

  Scenario: delete bookings ID 1
    Given path 'booking/1'
    And header Content-Type = 'application/json'
    And cookie token = 'abc123'
    When method DELETE
    Then status 403
    And print response
