*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library     REST          https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Test setup  Set headers   ${CURDIR}/headers.json


*** Variables ***
${base64_creds}     dmlhYUB2aWFhOnZpYXR3ZWVkdXVzZDMzJA==
&{basic_auth}       Authorization=Basic ${base64_creds}   # no quotes here!


*** Keywords ***
Set expectations
  Expect response           ${CURDIR}/schemas/users_current.json


*** Test Cases ***
Test listing of the webhooks
  [Tags]      rest  mediahaven  prd  qas  int
  Get         /webhooks
  Array       response body
  Integer     response status   200
  Expect Response   ${CURDIR}/schemas/webhooks.json
  Clear Expectations

Test listing of the exportlocations
  [Tags]      rest  mediahaven  prd  qas  int
  Get         /exportlocations
  Array       response body
  Integer     response status   200
  Expect Response   ${CURDIR}/schemas/exportlocations.json
  Clear Expectations

Test current user
  [Tags]      rest  mediahaven  prd  qas  int
  Get         /users/current
  Object      response body
  Integer     response status   200
  String      $.firstName       VIAA
  String      $.id              ff100f7a-efd0-44e3-8816-0905572421da
  String      $.login           viaa@viaa
  Expect Response   ${CURDIR}/schemas/users_current.json
  Clear Expectations
