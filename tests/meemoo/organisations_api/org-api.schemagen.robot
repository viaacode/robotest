*** Settings ***
Documentation    Generate JSON-schema's for the organisation-api.
Library       REST  http://${meemoo.services.org_api.url}/api


*** Tasks ***
Test getting an OR-id and generate a schema
  [Tags]      schemagen  qas  prd
  Get         /org/OR-rf5kf25
  Output      response body
  Integer     response status  200
  [Teardown]  Output Schema   response body   file_path=${CURDIR}/schemas/org_api_body.json
