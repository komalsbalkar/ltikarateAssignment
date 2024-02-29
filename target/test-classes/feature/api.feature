Feature: check ping health checkup by Api
 Background:
      * url 'https://restful-booker.herokuapp.com/'
      * header Accept = 'application/json'

Scenario: get ping health checkup 
    Given path 'ping'
    When method GET
    Then status 201