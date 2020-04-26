*** Settings ***
Documentation   Test #xxx\n
...             \n
...             See:
Library         REST    https://${mediahaven.rest.url}/mediahaven-rest-api/resources
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Resource        rest-resource.robot


*** Test Cases ***
Test generic local users
  [Tags]      rest  mediahaven  login   prd  qas  int
  &{json_string}=   GetSecret   mediahaven.generic_users
  ${json_users}=    Evaluate    json.loads("""${json_string.json}""")   json
  : FOR    ${user}     IN      @{json_users}
  \   Log To Console    Testing: ${user["username"]}
  \   Set auth header   ${user["username"]}  ${user["passwd"]}
  \   Get         /users/current
  \   Object      response body
  \   Integer     response status   200
  \   String      $.login           ${user["username"]}
  \   Expect Response   ${CURDIR}/schemas/users_current.json
  \   Clear Expectations
