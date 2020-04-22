*** Settings ***
Documentation    Generate JSON-schema's for the pid_webservice.
Library     REST  http://${meemoo.services.pid_webservice.url}

*** Tasks ***
Test the pid_webservice
  [Tags]      meemoo  schemagen
  Get         /
  Output      response
  Integer     response status   200
  [Teardown]  Output schema   file_path=${CURDIR}/schemas/pid_webservice.json
