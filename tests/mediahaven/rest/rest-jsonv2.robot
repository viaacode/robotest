*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST    https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Resource      ../http.resource
Test setup    Set auth header for     mediahaven     vnd.mediahaven.v2+json

*** Test Cases ***
Test media
  [Tags]      rest  mediahaven  prd  qas  int
  Expect Response    ${CURDIR}/schemas/mediav2.json
  Get         /media/?nrOfResults\=2
  Length Should Be      response body properties MediaDataList     3
  Integer     response status   200
  Clear Expectations

Test current user
  [Tags]      rest  mediahaven  prd  qas  int
  Expect Response    ${CURDIR}/schemas/users_currentv2.json
  Get         /users/current
  Object      response body
  Integer     response status   200
  String      $.firstName       VIAA
  String      $.id              ff100f7a-efd0-44e3-8816-0905572421da
  String      $.login           viaa@viaa
  Clear Expectations

Test generic local users
  [Tags]      rest  mediahaven  login   prd  qas  int
  Expect Response    ${CURDIR}/schemas/users_currentv2.json
  &{json_string}=    GetSecret     mediahaven.generic_local_users.${environment.short_name}
  ${generic_users}=  Set Variable  ${json_string.json}
  FOR    ${user}     IN      @{generic_users}
    Log To Console    Testing: ${user["username"]}
    Set auth header   ${user["username"]}  ${user["passwd"]}  vnd.mediahaven.v2+json
    Get         /users/current
    Object      response body
    Integer     response status   200
    String      $.login           ${user["username"]}
    Clear Expectations
  END

Test listing of the webhooks
  [Tags]      rest  mediahaven  prd  qas  int
  Expect Response    ${CURDIR}/schemas/webhooksv2.json
  Get         /webhooks
  Array       response body
  Integer     response status   200
  Clear Expectations

Test listing of the exportlocations
  [Tags]      rest  mediahaven  prd  qas  int
  Expect Response    ${CURDIR}/schemas/exportlocationsv2.json
  Get         /exportlocations
  Should Not Be Empty       response body
  Integer     response status   200
  Clear Expectations