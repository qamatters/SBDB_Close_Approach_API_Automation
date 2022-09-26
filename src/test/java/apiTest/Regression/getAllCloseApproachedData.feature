 @Regression

Feature: Validating SBDB Close- Approach Data API behaviour with respect to response time, version information, mandatory fields presence etc

  Background:

    Given url baseURL
    And path path

  @Smoke
  Scenario Outline: Validate that source name, version number,record count, total field count and mandatory fields along with data is present in response
    And param des = <asteroid des value>
    And param date-min = <date-min>
    And param date-max = <date-max>
    And param dist-max = <dist-max>
    When method GET
    Then status 200
    And response.signature.source = "NASA/JPL SBDB Close Approach Data API"
    And response.signature.version = "1.4"
    And print 'Total count:', response.count
    And response.count > 0
    And print response.fields
    And print 'Field count in response is:', response.fields.length
    And assert response.fields.length == 11
    And match response.fields == ["des","orbit_id","jd","cd","dist","dist_min","dist_max","v_rel","v_inf","t_sigma_f","h"]
    And match each response.data[*].length == response.count

    Examples:
      |asteroid des value   |date-min          |date-max     | dist-max    |
      |433                  | "1900-01-01"     |"2100-01-01" | 0.2         |

  Scenario: Validate that response count is 0 when there is no match as per the filters (params)
    And param des = "2000 SG344"
    When method GET
    Then status 200
    And response.signature.source = "NASA/JPL SBDB Close Approach Data API"
    And response.signature.version = "1.4"
    And print 'Total count:', response.count
    And assert response.count == 0

  @healthcheck
  Scenario Outline: Validate that API successfully responds within 10 seconds with a size less then 2000kb when correct data is provided for asteroid des value, date-min, date max and sit-max fields
    And param des = <asteroid des value>
    And param date-min = <date-min>
    And param date-max = <date-max>
    And param dist-max = <dist-max>
    When method GET
    Then status 200
    And print 'Response time for this API is:', responseTime
    And assert responseTime < 10000
    And print 'Response size for this API is:', responseBytes.length
    And assert responseBytes.length < 2000

    Examples:
      |asteroid des value   |date-min          |date-max     | dist-max    |
      |433                  | "1900-01-01"     |"2100-01-01" | 0.2         |

  Scenario Outline: Validate server name in API response header
    And param des = <asteroid des value>
    And param date-min = <date-min>
    And param date-max = <date-max>
    And param dist-max = <dist-max>
    When method GET
    Then status 200
    And def contentType = responseHeaders['Content-Type'][0]
    And print 'Content type header value in Response Header is:', contentType
    And assert contentType == "application/json"
    And def Server = responseHeaders['Server'][0]
    And print 'Server header value in Response Header is:', Server
    And assert Server == "nginx"

    Examples:
      |asteroid des value   |date-min          |date-max     | dist-max    |
      |"2000 SG344"         | "1900-01-01"     |"2100-01-01" | 0.2         |
