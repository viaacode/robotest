*** Settings ***
Library       REST  http://${meemoo.services.org_api.url}/api


*** Keywords ***
Set expectations
  Expect response           ${CURDIR}/schemas/org_api.json


*** Test Cases ***
Test getting an OR-id (uppercase)
  [Tags]      meemoo  rest  prd  qas
  Get         /org/OR-rf5kf25
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-rf5kf25
  String      $.data.cp_name_mam  vrt

Test getting an or-id (lowercase)
  [Tags]      meemoo  rest  prd  qas  regression
  Get         /org/or-rf5kf25
  Output      response body
  Integer     response status     200
  String      $.status            success
  String      $.data.or_id        OR-rf5kf25
  String      $.data.cp_name_mam  vrt
