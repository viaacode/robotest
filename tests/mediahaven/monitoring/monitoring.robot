*** Settings ***
Documentation     A test suite for the monitoring back-office
...
...               A single valid login test for the MediaHaven
...               monitoring back-office
Resource          monitoring-resource.robot

*** Test Cases ***
Valid Login to MH monitoring interface
    [Tags]    web-test  login  mediahaven  prd  qas  int
    Open Browser To Login Page
    ${username}=    Get username from vault   mediahaven
    ${passwd}=      Get passwd from vault     mediahaven
    Input Username    ${username}
    Input Password    ${passwd}
    Submit Credentials
    Index Page Should Be Open
    Index Page Should Have All Tabs
    [Teardown]    Close Browser
