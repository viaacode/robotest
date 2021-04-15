*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST    https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Library       RequestsLibrary
Library       XML     use_lxml=True
Resource      ../http.resource
Suite Setup       Create RequestsSession with headers   mediahaven   https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Test setup    Set auth header for     mediahaven     vnd.mediahaven.v2+xml

*** Test Cases ***
Test Current User
    [Tags]                  rest  mediahaven  prd  qas  int
    ${resp}=                Get Request     mediahaven     /users/current
    Status Should Be        200             ${resp}
    ${root}=                Parse XML       ${resp.content}
    Element Should Exist    ${root}       /userInfo
    Element Text Should Be  ${root}       VIAA     /userInfo/firstName
    Element Text Should Be  ${root}       ff100f7a-efd0-44e3-8816-0905572421da     /userInfo/id  
    Element Text Should Be  ${root}       viaa@viaa     /userInfo/login