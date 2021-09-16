*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST    https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Resource      ../http.resource
Test setup    Set auth header for     mediahaven.admin_user.${environment.short_name}

*** Test Cases ***
Test current user
  [Tags]      rest  mediahaven  prd  qas  int
  Get         /users/current
  Object      response body
  Integer     response status   200
  Expect Response   ${CURDIR}/schemas/users_current.json
  Clear Expectations

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

