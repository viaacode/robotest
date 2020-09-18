*** Settings ***
Documentation    An automation to export test files from production.
Library          REST https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Resource         ../http.resource
Resource         ingest-resource.robot
Test setup       Set auth header for mediahaven

*** Test Cases ***
Export test files from production to int
    [Tags]             ingest mediahaven int
    ${files_query}=    %2B(Title:"Test tape ingest QAS")
    Get                /media/?q=${files_query}
    Object             response body
    Integer            response status 200
    String             $.TotalNrOfResults 24
    : FOR    ${result}    IN    @{$.MediaDataList}
    \   Post /media/${result}.Internal.FragmentId/export/844
    Clear Expectations