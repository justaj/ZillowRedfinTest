@Redfin

Feature: Test Redfin

@login
Scenario: Test login and search filters
  Given I want to use the browser "Chrome"
  When I navigate to "https://www.redfin.com"
  Then I verify I "am not" signed in
  And I "login" to Redfin
  Then I verify I "am" signed in
  Then I search for "Corona,CA" in the search field
  Then I add the filters "House=true,MinBeds=4" to the search
  And I assert the search results
