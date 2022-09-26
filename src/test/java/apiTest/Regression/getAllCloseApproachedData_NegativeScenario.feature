@Regression

Feature: Validating SBDB Close- Approach Data API behaviour when invalid values are provided in API request

  Background:

    Given url "https://ssd-api.jpl.nasa.gov/"
    And path 'cad.api'

  @Smoke
  Scenario Outline: Validate "invalid value specified for query parameter" in response message when invalid value is provided to date field
    And param des = <asteroid des value>
    And param date-min = <date-min>
    And param date-max = <date-max>
    And param dist-max = <dist-max>
    When method GET
    Then status 400
    And response.code = "400"
    And response.moreInfo == "https://ssd-api.jpl.nasa.gov/doc/cad.html"
    And response.message == "invalid value specified for query parameter 'date-min': invalid datetime specified (expected 'YYYY-MM-DD', 'YYYY-MM-DDThh:mm:ss', 'YYYY-MM-DD_hh:mm:ss' or 'YYYY-MM-DD hh:mm:ss')"


    Examples:
      |asteroid des value   |date-min                       |date-max     | dist-max    |
      |433                  | "textasstringindatefield"     |"2100-01-01" | 0.2         |

  Scenario Outline: Validate "invalid number and/or units" in response message when invalid value is provided to distance field
    And param des = <asteroid des value>
    And param date-min = <date-min>
    And param date-max = <date-max>
    And param dist-max = <dist-max>
    When method GET
    Then status 400
    And print 'Response time for this API is:', responseTime
    And response.message == "invalid number and/or units"

    Examples:
      |asteroid des value   |date-min          |date-max     | dist-max    |
      |433                  | "1900-01-01"     |"2100-01-01" | "deepak"      |

  Scenario: Validate "one or more query parameter was not recognized" in response message when one of the query parameter is sent incorrectly in request
    And param des1 = 433
    When method GET
    Then status 400
    And response.message == "one or more query parameter was not recognized"


  Scenario: Validate "Invalid HTTP method: must be GET or POST" in response message when request is sent with invalid method type
    And param des = 433
    When method Put
    Then status 405
    And response.message == "Invalid HTTP method: must be GET or POST"

  Scenario: Validate "Invalid designation" in response message when dest is sent with invalid value
    And param des = "test123"
    When method GET
    Then status 400
    And response.message == "invalid designation"

  Scenario: Validate "invalid character in designation" in response message when dest is sent with empty string
    And param des = ""
    When method GET
    Then status 400
    And response.message == "invalid character in designation"