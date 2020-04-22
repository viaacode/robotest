*** Settings ***
Documentation    Test #022\n
...              Generate JSON-schema's for MH-rest.
Library     REST          https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Test setup  Set headers   ${CURDIR}/headers.json


*** Tasks ***
List the webhooks and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /webhooks
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/webhooks.json

List the exportlocations and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /exportlocations
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/exportlocations.json

Lookup current user and generate a schema
  [Tags]      schemagen  rest  mediahaven  prd  qas  int
  Get         /users/current
  Output      response body
  Integer     response status  200
  [Teardown]  Output schema    file_path=${CURDIR}/schemas/users_current.json

