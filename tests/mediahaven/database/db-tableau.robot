*** Settings ***
Documentation     A test suite for the database access
...
...               A single valid login test for the MediaHaven tableau user in the database
Resource          db-resource.robot

*** Test Cases ***
Tableau Login to MH postgresql db
    [Tags]    tableau  login  mediahaven  prd  qas  int
    ${username}=    Get username from vault   mediahaven.tableau
    ${passwd}=      Get passwd from vault     mediahaven.tableau
    Connect To Mediahaven DB    ${username}     ${passwd}
    Sips View Should Be Readable
    [Teardown]    Disconnect From Mediahaven DB
