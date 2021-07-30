*** Settings ***
Library       REST  http://${meemoo.services.org_api.url}/api


*** Keywords ***
Set expectations
  Expect response           ${CURDIR}/schemas/org_api.json


*** Test Cases ***
2.1 Test getting an OR-id (uppercase)
  [Tags]      meemoo  rest  prd  qas
  Get         /org/OR-rf5kf25
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-rf5kf25
  String      $.data.cp_name_mam  vrt

2.1 Test getting an or-id (lowercase)
  [Tags]      meemoo  rest  prd  qas  regression
  Get         /org/or-rf5kf25
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-rf5kf25
  String      $.data.cp_name_mam  vrt

2.1 Test the completeness of the API data
  [Tags]      meemoo  rest  prd  qas
  [Documentation]   For certain OR-id's, the response should be complete.
  Get         /org/OR-rf5kf25
  Output      response body
  Integer     response status         200
  String      $.status                success
  String      $.data.or_id            OR-rf5kf25
  String      $.data.cp_name_catpro   minLength=1     
  String      $.data.description      minLength=1     
  String      $.data.accountmanager   minLength=1     
  Expect response   ${CURDIR}/schemas/org_api_completeness.json
