*** Settings ***
Documentation     A test suite for the monitoring back-office
...
...               A single valid login test for the MediaHaven
...               monitoring back-office
Resource          mh-resource.robot

*** Test Cases ***
Valid Login to MH monitoring interface
    [Tags]    web-test  login  mediahaven  prd  qas  int
    Open Browser To Login Page
    Input Username    ${VALID_USER}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials
    Index Page Should Be Open
    [Teardown]    Close Browser
