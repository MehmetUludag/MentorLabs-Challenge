Feature: Faz2-Spotify
  Background:
    * configure driver = {type:'chromedriver' , executable:'src/test/java/resources/chromedriver.exe'}
    * driver "https://open.spotify.com"
    * maximize()
    * delay(1000)
    * def userid = '31fro6ogea4w4mbtxywcu4qomzui'
    * def token = 'Bearer BQDxT372nlFgoRR-NG7HcboAvadB-8GPnJ4G9KyPPicv9Pme5Xlcpcstu0HKhKUthbwDZz8orQvUnKk9GQr09F4eVzAfk51tLnvANb94ywUzrYQpYkdgV9xOtapJwk7K1PUyYErzG6NtPN8VLjdxTsgYmNJ5_0MjDrHteKc7iU9oxzsiJMeDjaXGLtzfx6LWbtUhCjQXhndOp_dEz9pHuuUUlTffH-lGTTJ01gdJ3fIxLhrhX5n5VtB8-_7cZxCos_xuTH8tuLalXiI3xIM6'
    *  def requestbody =
     """
     {
      "name": " MentorLabs Faz2",
      "description": "New playlist description",
      "public": false,
    }
     """
    * def requestAdditembody =
     """
     {
      "uris": [
        "spotify:track:3MrRksHupTVEQ7YbA0FsZK"
      ]
    }
     """

  @ignore
  @Playlist_id
  Scenario: Create Playlist
    Given url 'https://api.spotify.com/v1/'
    And path '/users/'+userid+'/playlists'
    And header Authorization = token
    And request requestbody
    When method post
    * def playId = response.id
    Then status 201

  @ignore
  @Searching
  Scenario: Search The Final Countdown
    Given url 'https://api.spotify.com/v1/'
    And path '/search'
    And header Authorization = token
    And header Content-Type = 'application/json'
    And param q = 'The Final Countdown'
    And param type = 'track'
    When method get
    Then status 200

  @ignore
  @AddTracks
  Scenario: Add tracks to Playlist
    * def Playlist_id = call read('faz2.feature@Playlist_id')
    * def playlist_id = Playlist_id.playId
    Given url 'https://api.spotify.com/v1/'
    And path '/playlists/'+playlist_id+'/tracks'
    And header Authorization = token
    And header Content-Type = 'application/json'
    And request requestAdditembody
    When method post
    Then status 201

  @ignore
  @TrackControl
  Scenario: Get Currently Played Track
    Given url 'https://api.spotify.com/v1'
    And path '/me/player/currently-playing'
    And header Authorization = token
    When method get
    And waitFor('.AINMAUImkAYJd4ertQxy').click()
    And waitFor('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set').click()
    And delay(5000)
    Then match response.item.name == "The Final Countdown"
    And delay(1000)




  Scenario: Hybrid Test
    Given click('.ButtonInner-sc-14ud5tc-0.iebPZv.encore-inverted-light-set')
    And waitFor('.Input-sc-1gbx9xe-0.iFfIqr').input('mehmet.uludag@testinium.com')
    And input("//input[@placeholder='Parola']", '1@2w3e4r5t')
    When click('.ButtonInner-sc-14ud5tc-0.lbsIMA.encore-bright-accent-set')
    And delay(1500)
    * def add_final_countdown = call read('faz2.feature@AddTracks')
    And delay(1500)
    And refresh()
    And delay(1000)
    * def track_control = call read('faz2.feature@TrackControl')
    Then delay(1500)

