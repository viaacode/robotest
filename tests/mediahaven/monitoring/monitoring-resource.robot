*** Settings ***
Documentation     A resource file with higher-order keywords for MH Monitoring.
Library           SeleniumLibrary
Library           Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False

*** Variables ***
${SERVER}           ${mediahaven.monitoring.url}
${BROWSER}          headlessfirefox
${DELAY}            0.5
${LOGIN_URL}        https://${SERVER}/login.php

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Wait Until Page Contains    Login

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Open IDP page
    Click Button    xpath://button[@name="serviceLogin" and @value="viaa"]
    Wait Until Page Contains Element    id:loginform

Input Username MediaHaven
    [Arguments]    ${username}
    Input Text     id:input-field-username   ${username}

Input Password MediaHaven
    [Arguments]    ${password}
    Input Text     id:input-field-password    ${password}

Submit Credentials MediaHaven
    Click Button   xpath://button[@name="serviceLogin" and @value="mediahaven"]
    Allow access if needed

Input Username IDP meemoo
    [Arguments]    ${username}
    Input Text     id:inputUsername   ${username}

Input Password IDP meemoo
    [Arguments]    ${password}
    Input Text     id:inputPassword    ${password}

Submit Credentials IDP meemoo
    Click Button     id:wp-submit

Allow access if needed
    Sleep   1s  Wait to allow the access dialog to show if needed
    ${count}=   Get Element Count    xpath://button[@name="giveperms" and @value="true"]
    Run Keyword If      $count == 1     Click Button    xpath://button[@name="giveperms" and @value="true"]

Logout
    Click Link      id:logout

Index Page Should Be Open
    Wait Until Location Contains    index.php
    Location Should Contain         index.php
    Page Should Contain Element     id:logout

Index Page Should Not Be Open
    Wait Until Page Contains        has no permission to view backend monitoring
    Location Should Contain         error.php

Index Page Should Have All Tabs
    Page Should Contain Element     link:Ingest
    Page Should Contain Element     link:Transcoding
    Page Should Contain Element     link:Export
    Page Should Contain Element     link:MediaHaven
    Page Should Contain Element     link:Server Logs
    Page Should Contain Element     link:Statistics

Get username from vault
    [Arguments]     ${path}
    &{secret_key}=  GetSecret   ${path}
    [return]        ${secret_key.username}

Get passwd from vault
    [Arguments]     ${path}
    &{secret_key}=  GetSecret   ${path}
    [return]        ${secret_key.passwd}
