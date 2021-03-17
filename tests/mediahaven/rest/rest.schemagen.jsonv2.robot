*** Settings ***
Documentation    Test #022\n
...              Generate JSON-schema's for MH-rest.
Library     REST          https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Resource      ../http.resource
Test setup    Set auth header for     mediahaven     vnd.mediahaven.v2+json


*** Tasks ***
Get a media result and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /media/?nrOfResults=1
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/mediav2.json

List the webhooks and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /webhooks
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/webhooksv2.json

List the exportlocations and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /exportlocations
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/exportlocationsv2.json

Lookup current user and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /users/current
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/users_currentv2.json
