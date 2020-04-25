*** Settings ***
Documentation    Test #xxx\n
...              Are the FTP users configured properly.\n
...              See: 
Library          FtpLibrary
Library          Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False

*** Test Cases ***
Test av user login
    [Tags]        ftp  mediahaven  prd  qas  int
    &{secret_key}=  GetSecret   mediahaven.ftp_tra.av
    ftp connect     ${mediahaven.ftp_tra.url}    av    ${secret_key.passwd}
    ${welcomeMsg}=  get welcome
    Log             ${welcomeMsg}
    ftp close

Test bbviaa user login
    [Tags]        ftp  mediahaven  prd  qas  int
    &{secret_key}=  GetSecret   mediahaven.ftp_tra.bbviaa
    ftp connect     ${mediahaven.ftp_tra.url}    bbviaa    ${secret_key.passwd}
    ${welcomeMsg}=  get welcome
    Log             ${welcomeMsg}
    ftp close

Test sidecar user login
    [Tags]        ftp  mediahaven  prd  qas  int
    &{secret_key}=  GetSecret   mediahaven.ftp_tra.sidecar
    ftp connect     ${mediahaven.ftp_tra.url}    sidecar    ${secret_key.passwd}
    ${welcomeMsg}=  get welcome
    Log             ${welcomeMsg}
    ftp close
