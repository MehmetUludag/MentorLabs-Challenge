Feature: Apı Testing
  Background:
    * def urlHome = 'https://open.spotify.com/'
    * def userid = '31fro6ogea4w4mbtxywcu4qomzui'
    * def token = 'Bearer BQCg36rOUMiP7sihEqVy9cRIFvrEdwG_GKcnRzji_HHePpgKJ3arJvTOzU0tDKhnJmQyAVpZvb4F_pUaYnM_omjfdnRD5LuD_26_ZV2cbIyE1BrmY9x2xUlAuIAnpPduSxmHFeU8KGWnjjXHYD-CHzdGonLkg6czjGfUzT390p6K4hOHlD5DuWRiAy2ENJsrskVBbYez0y4FsXUED66TM46sC5x85YfYstZ4rXp-4gOGwGd0ddSk-MWsudKBlquqfg'
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

  @ignore
  @Playlist_id
  Scenario: Create Playlist
    Given url 'https://api.spotify.com/v1/'
    And path '/users/'+userid+'/playlists'
    And header Authorization = token
    And request requestbody
    When method post
    * def playId = response.id

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

