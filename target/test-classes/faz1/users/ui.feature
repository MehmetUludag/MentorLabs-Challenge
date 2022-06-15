Feature: Faz1_Spotify

  Background:
    * configure driver = {type:'chromedriver' , executable:'src/test/java/resources/chromedriver.exe'}
    * driver "https://open.spotify.com"
    * maximize()
    * delay(1000)

  Scenario: UI Test
    Given click('.ButtonInner-sc-14ud5tc-0.iebPZv.encore-inverted-light-set')
    When delay(1000)
    And input('.Input-sc-1gbx9xe-0.iFfIqr', 'mehmet.uludag@testinium.com')
    And input("//input[@placeholder='Parola']", '1@2w3e4r5t')
    And click('.ButtonInner-sc-14ud5tc-0.lbsIMA.encore-bright-accent-set')
    And click('.IPVjkkhh06nan7aZK7Bx')
    And delay(2000)
    And click('.Type__TypeElement-goli3j-0.hVBZRJ')
    And input('.f0GjZQZc4c_bKpqdyKbq.JaGLdeBa2UaUMBT44vqI', 'MentorLabs Challenge')
    And click('.ButtonInner-sc-14ud5tc-0.iebPZv.encore-inverted-light-set')
    And input('.Type__TypeElement-goli3j-0.ebHsEf.l42JW4EP_5CU1Ba7jYIc', 'Daft Punk')
    And click("//button[@data-testid='add-to-playlist-button']")
