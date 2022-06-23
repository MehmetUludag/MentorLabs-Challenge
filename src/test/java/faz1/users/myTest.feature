Feature: My End to End Test

  Background:
    * configure driver = {type:'chromedriver' , executable:'src/test/java/resources/chromedriver.exe'}
    * driver "https://open.spotify.com"
    * maximize()
    * delay(1000)
    * def userid = '31fro6ogea4w4mbtxywcu4qomzui'
    * def token = 'Bearer BQAu8XIXqdiU2Z11D2r9tlPwXh4QkisebJSBuMaSM9iWurT6-8OVA-8HxFDxwxpAHhbfhXOBYhZEb7py3M9Ey2jSVGtMKKwsM_iBT92PdHfNRxfEL4TfYko45Ufh3bSNBaFqpkADSoylpdR7rcOT0A0tQzVedcd3woe8MOb3iFwpv2IB0ZDq9Y3M2vF3WhAUsf-_X-NCfbI8OIpt0_7tLgug26Xa3wWZShQBXLDtha21eFrCb-eo3ZkUkiEMwH9heOlzgc96jmwRSYXjYnefiP42IlZBlg'
    * def requestbody =
  """
    {
      "name": "My Playlist",
      "description": "New playlist description",
      "public": false
    }
  """

  Scenario: MyTest

    #Sisteme başarılı şekilde giriş yapılır.
    Given click('.ButtonInner-sc-14ud5tc-0.iebPZv.encore-inverted-light-set')
    And waitFor('.Input-sc-1gbx9xe-0.iFfIqr').input('mehmet.uludag@testinium.com')
    And input("//input[@placeholder='Parola']", '1@2w3e4r5t')
    And click('.ButtonInner-sc-14ud5tc-0.lbsIMA.encore-bright-accent-set')

    #Arama butonundan "Enter Sandman" aratılır.
    And waitFor("//a[@class='link-subtle ATUzFKub89lzvkmvhpyE']").click()
    And waitFor('.Type__TypeElement-goli3j-0.ebHsEf.QO9loc33XC50mMRUCIvf').input('enter sandman')

    #Parça oynatılır ve beğen butonuna basılır.
    And waitFor('._gB1lxCfXeR8_Wze5Cx9').click()
    And waitFor('.ButtonInner-sc-14ud5tc-0.gHYQaG.encore-bright-accent-set').click()
    And delay(5000)
    And waitFor('.Fm7C3gdh5Lsc9qSXrQwO').click()

    #Doğru parçanın oynadığı kontrol edilir.
    Given url 'https://api.spotify.com/v1'
    And path '/me/player/currently-playing'
    And header Authorization = token
    When method get
    Then match response.item.name == "Enter Sandman"

    #"My Playlist" adında yeni oynatma listesi oluşturulur.
    Given url 'https://api.spotify.com/v1/'
    And path '/users/'+userid+'/playlists'
    And header Authorization = token
    And request requestbody
    When method post
    * def playlist_id = response.id
    Then status 201

    Given refresh()

    #Beğenilere eklenen şarkı "My Playlist" çalma listesine eklenir.
    Given url 'https://api.spotify.com/v1/'
    And path 'me/tracks'
    And header Authorization = token
    When method get
    Then def songUri = response.items[0].track.uri

    Given url 'https://api.spotify.com/v1/'
    And path '/playlists/' + playlist_id + '/tracks'
    And header Authorization = token
    And def body = {"uris":[#(songUri)]}
    And request body
    When method post

