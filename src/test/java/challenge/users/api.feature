Feature: Apı Testing
  Background:
    * def userid = '31fro6ogea4w4mbtxywcu4qomzui'
    * def token = 'Bearer BQBpb33LzkO9-iTKhFoh1hMtDpHjHUmqNAGbpsx9tF9s6DfFIuZO19zgsNkQwCwdZKwn0pJQdvVbEDE3857rafJUOFfgczenO6TDla0e-YA8jMIdsKK05m3B4lEjdcynxI96oHK8Mw2_VxCAT4cUo2e-QS4VE79af0-QVbcPOQ9QOc6NK9Rptf1_GOMMdK0CxR4kKKiBVRYfLA4SdQ3J4mZEJK6Kup4KD2ZNIT3b6EdFGc0f2Hpo3aQkfsO_DFCmNWhnXG4xQZWf'
    *  def requestbody =
 """
 {
  "name": " Mehmet's Playlist",
  "description": "New playlist description",
  "public": false,
}
 """
    * def requestAdditembody =
 """
 {
  "uris": [
    "spotify:track:2XbcujvemK0hGh0Ob4HAXQ"
  ]
}
 """

  @GetPlaylist
  Scenario: Get Playlist User
    Given url 'https://api.spotify.com/v1/'
    And path '/me'
    And header Authorization = token
    When method get
    Then status 200

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
  Scenario: Search Bohemian Rhapsody
    Given url 'https://api.spotify.com/v1/'
    And path '/search'
    And header Authorization = token
    And header Content-Type = 'application/json'
    And param q = 'Bohemian Rhapsody'
    And param type = 'track'
    When method get
    Then status 200

  @AddTracks
  Scenario: Add tracks to Playlist
    * def Playlist_id = call read('api.feature@Playlist_id')
    * def searching = call read('api.feature@Searching')
    * def playlist_id = Playlist_id.playId
    Given url 'https://api.spotify.com/v1/'
    And path '/playlists/'+playlist_id+'/tracks'
    And header Authorization = token
    And header Content-Type = 'application/json'
    And request requestAdditembody
    When method post
    Then status 201


