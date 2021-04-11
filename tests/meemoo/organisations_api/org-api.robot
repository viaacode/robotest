*** Settings ***
Library       REST  http://${meemoo.services.org_api.url}/api
Suite setup   Expect Response Body   ${CURDIR}/schemas/org_api_body.json


*** Test Cases ***
Test getting an OR-id (uppercase)
  [Tags]      meemoo  rest  prd  qas
  Get         /org/OR-rf5kf25
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-rf5kf25
  String      $.data.cp_name_mam  vrt
  Clear Expectations

Test getting an OR-id with less data
  [Tags]      meemoo  rest  prd  qas
  [Documentation]  Some OR-id's carry less data.\nThese should still validate against the schema.
  Get         /org/OR-h41jm1d
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-h41jm1d
  String      $.data.cp_name_mam  testbeeld
  Clear Expectations

Test the completeness of the API data
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
  Clear Expectations
