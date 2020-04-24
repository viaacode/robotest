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
    Page Should Contain Element     id:login

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text     id:inputEmail3    ${username}

Input Password
    [Arguments]    ${password}
    Input Text     id:inputPassword3    ${password}

Submit Credentials
    Submit Form

Index Page Should Be Open
    Wait Until Location Contains    index.php    
    Location Should Contain         index.php
    Page Should Contain Element     id:logout

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
