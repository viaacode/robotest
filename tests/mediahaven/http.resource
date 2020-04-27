*** Settings ***
Documentation   A resource file with higher-order keywords for Basic auth headers.
Library         Collections
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False


*** Keywords ***
Set auth header
    [Arguments]         ${username}     ${passwd}
    ${userpass}=        Convert To Bytes    ${username}:${passwd}
    ${userpass}=        Evaluate    base64.b64encode($userpass)    base64
    ${headers}=         Create Dictionary   Authorization=Basic ${userpass}
    Set To Dictionary   ${headers}          Accept=application/vnd.mediahaven.v2+json
    Set headers         ${headers}

Set auth header for
    [Arguments]       ${path}
    &{secret_key}=    GetSecret   ${path}
    Set auth header   ${secret_key.username}  ${secret_key.passwd}
