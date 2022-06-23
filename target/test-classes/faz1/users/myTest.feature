Feature: My End to End Test

  Background:
    * configure driver = {type:'chromedriver' , executable:'src/test/java/resources/chromedriver.exe'}
    * driver "https://open.spotify.com"
    * maximize()
    * delay(1000)
    * def userid = '31fro6ogea4w4mbtxywcu4qomzui'
    * def token = 'Bearer BQAi2dTJPxaEP9EYkHgctaNW5x_h5-qlnqLn-wMgD4R9KTH3ReEtHH-gwKJ_uurxDmJJG8dGEB8jHp7C_9M1o7tqcn8TEKMacujm8GdI4TtxrEv11kJGOim8pyT1jvNyQAGRQa5JQKcBmxUszho_lWa9tpzWrSUDIWutrdUqs6nEVMa5WZT0VoebAsMFirXpaBqQZdTei5JSZUwaFRlGND0fdQopgopnKjwfy2Pjl60VQfjldRKX6DF4P9ORC6JlUjLi53je1OsbeEXHB0k'
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
    Then status 201

    Given refresh()

    #Beğenilere eklenen şarkı "My Playlist" çalma listesine eklenir.
    And waitFor('.r9YzlaAPnM2LGK97GSfa').click()
    And waitFor('.T0anrkk_QA4IAQL29get.mYN_ST1TsDdC6q1k1_xs').click()
    And retry().click("(//*[@class='wC9sIed7pfp47wZbmU6m'])[5]")
    And retry().click("(//*[text()='My Playlist'])[2]")

    And delay(5000)
