*** Settings ***
Documentation   A resource file with higher-order keywords for Basic auth headers.
Library         Collections
Library         RequestsLibrary
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False


*** Keywords ***
Set auth header
    [Arguments]         ${username}     ${passwd}
    ${userpass}=        Convert To Bytes    ${username}:${passwd}
    ${userpass}=        Evaluate    base64.b64encode($userpass)    base64
    ${headers}=         Create Dictionary   Authorization=Basic ${userpass}
    Set To Dictionary   ${headers}          Accept=application/vnd.mediahaven.v2+json
    Set headers         ${headers}

Get auth header
    [Arguments]         ${username}     ${passwd}
    ${userpass}=        Convert To Bytes    ${username}:${passwd}
    ${userpass}=        Evaluate    base64.b64encode($userpass)    base64
    ${headers}=         Create Dictionary   Authorization=Basic ${userpass}
    [Return]            ${headers}

Set auth header for
    [Arguments]       ${path}
    &{secret_key}=    GetSecret   ${path}
    Set auth header   ${secret_key.username}  ${secret_key.passwd}

Get auth header for
    [Arguments]       ${path}
    &{secret_key}=    GetSecret   ${path}
    ${headers}        Get auth header   ${secret_key.username}  ${secret_key.passwd}
    [Return]          ${headers}

Create RequestsSession with headers
    [Arguments]         ${alias}        ${url}
    ${headers}=         Get auth header for     mediahaven
    Set To Dictionary   ${headers}      Accept=application/xml
    Create Session      ${alias}        ${url}   ${headers}