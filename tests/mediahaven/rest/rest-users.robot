*** Settings ***
Documentation   Test #xxx\n
...             \n
...             See:
Library         REST    https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Resource        ../http.resource


*** Test Cases ***
Test generic local users
  [Tags]      rest  mediahaven  login   prd  qas  int
  &{json_string}=    GetSecret     mediahaven.generic_local_users.${environment.short_name}
  ${generic_users}=  Set Variable  ${json_string.json}
  FOR    ${user}     IN      @{generic_users}
    Log To Console    Testing: ${user["username"]}
    Set auth header   ${user["username"]}  ${user["passwd"]}
    Get         /users/current
    Object      response body
    Integer     response status   200
    String      $.login           ${user["username"]}
    Expect Response   ${CURDIR}/schemas/users_current.json
    Clear Expectations
  END
  
