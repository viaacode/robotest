*** Settings ***
Documentation   Test #xxx\n
...             \n
...             See:
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Resource        monitoring-resource.robot


*** Test Cases ***
Test generic local users
  [Tags]      rest  mediahaven  login   prd  qas  int
  &{json_string}=   GetSecret   mediahaven.generic_ldap_users
  ${json_users}=    Evaluate    json.loads("""${json_string.json}""")   json
  FOR    ${user}     IN      @{json_users}
    Log To Console    Testing: ${user["username"]}
    Open Browser To Login Page
    Input Username   ${user["username"]}
    Input Password   ${user["passwd"]}
    Submit Credentials
    Index Page Should Be Open
    Logout
  END
  [Teardown]    Close Browser
