*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
...               The keywords defined here are, thus, higher-order keywords.
Library           SeleniumLibrary

*** Variables ***
${SERVER}           ${mediahaven.monitoring.url}
${BROWSER}          headlessfirefox
${DELAY}            0.5
${VALID_USER}       ${mediahaven.monitoring.validuser}
${VALID_PASSWORD}   ${mediahaven.monitoring.validpasswd}
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
