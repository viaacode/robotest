*** Settings ***
Documentation     A resource file with higher-order keywords for DB Monitoring.
Library           DatabaseLibrary
Library           Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False

*** Variables ***
${HOST}            ${mediahaven.database.url}
${DB}              mediahaven_data
${PORT}            1433
${DBMODULE}        psycopg2

*** Keywords ***    
Get username from vault
    [Arguments]     ${path}
    &{secret_key}=  GetSecret   ${path}
    [return]        ${secret_key.username}

Get passwd from vault
    [Arguments]     ${path}
    &{secret_key}=  GetSecret   ${path}
    [return]        ${secret_key.passwd}

Connect To Mediahaven DB
    [Arguments]     ${username}     ${passwd}
    Connect To Database     ${DBMODULE}     ${DB} 	${username} 	${passwd} 	${HOST} 	${PORT}

Disconnect From Mediahaven DB
    Disconnect From Database

Sips View Should Be Readable
    Check If Exists In Database     select viewname from pg_catalog.pg_views where viewname IN ('sips');
