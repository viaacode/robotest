*** Settings ***
Library     REST  http://${meemoo.services.pid_webservice.url}


*** Test Cases ***
Test the pid_webservice
  [Tags]      meemoo  rest  prd   qas
  Get         /
  Output      response
  Integer     response status   200
  Expect Response   ${CURDIR}/schemas/pid_webservice.json
