*** Settings ***
Documentation   Test #xxx\n
...             \n
...             See:
Library         Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Resource        monitoring-resource.robot


*** Test Cases ***
Test generic LDAP users
  [Tags]      web  mediahaven  login   prd  qas  int
  &{json_string}=   GetSecret   mediahaven.generic_ldap_users.${environment.short_name}
  ${generic_users}=  Set Variable  ${json_string.json}
  FOR    ${user}     IN      @{generic_users}
    Log To Console    Testing: ${user["username"]}
    Open Browser To Login Page
    Input Username   ${user["username"]}
    Input Password   ${user["passwd"]}
    Submit Credentials
    Index Page Should Not Be Open
  END
  [Teardown]    Close Browser

Test generic local users
  [Tags]      web  mediahaven  login   prd  qas  int
  &{json_string}=    GetSecret     mediahaven.generic_local_users.${environment.short_name}
  ${generic_users}=  Set Variable  ${json_string.json}
  FOR    ${user}     IN      @{generic_users}
    Log To Console    Testing: ${user["username"]}
    Open Browser To Login Page
    Input Username   ${user["username"]}
    Input Password   ${user["passwd"]}
    Submit Credentials
    Index Page Should Be Open
    Logout
  END
  [Teardown]    Close Browser
