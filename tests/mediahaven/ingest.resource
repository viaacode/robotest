*** Settings ***
Documentation   A resource file with higher-order keywords for repeatable ingest actions.
Library         REST    https://${mediahaven.rest.url}
Library       Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Library          FtpLibrary
Library          String
Resource      ../http.resource


*** Keywords ***
Sidecar upload
    [Arguments]         ${localpath}     ${remotepath}
    &{secret_key}=  GetSecret   mediahaven.ftp_tra.sidecar
    ftp connect     ${mediahaven.ftp_tra.url}    sidecar    ${secret_key.passwd}
    ${xmllocalpath}=    Fetch From Left     ${localpath}      .
    ${xmllocalpath}=    Catenate    SEPARATOR=    ${xmllocalpath}   .xml
    ${xmlremotepath}=    Fetch From Left     ${remotepath}      .
    ${xmlremotepath}=    Catenate    SEPARATOR=    ${xmlremotepath}   .xml
    Log             Uploading file from ${xmllocalpath}
    Log             Uploading xml from ${localpath}
    Upload File     ${xmllocalpath}     remoteFileName=${xmlremotepath}
    Upload File     ${localpath}     remoteFileName=${remotepath}
    [Teardown]     ftp close

Essence only upload
    [Arguments]         ${localpath}     ${remotepath}
    &{secret_key}=  GetSecret   mediahaven.ftp_tra.bbviaa
    ftp connect     ${mediahaven.ftp_tra.url}    bbviaa    ${secret_key.passwd}
    Log             Uploading file from ${localpath}
    Upload File     ${localpath}     remoteFileName=${remotepath}
    [Teardown]     ftp close

Mediahaven delete
    [Arguments]         ${Md5}
    Check If Exists     ${Md5}
    ${resp}=    Get Object Response        ${Md5}
    ${fragmentId}=     Set Variable         ${resp["body"]["MediaDataList"][0]["Internal"]["FragmentId"]}
    ${resp}=    REST.Delete    mediahaven-rest-api/resources/media/${FragmentId}

Check If Exists
    [Arguments]         ${Md5}
    Get Object Response        ${Md5}
    ${results}=        Integer     response body TotalNrOfResults
    ${expectedresults}=     Create list    ${1}
    Should Be Equal     ${results}     ${expectedresults}

Check If On Tape
    [Arguments]         ${Md5}
    ${resp}=              Get Object Response        ${Md5}
    ${ArchiveStatus}=     Set Variable         ${resp["body"]["MediaDataList"][0]["Internal"]["ArchiveStatus"]}
    Should Be Equal     ${ArchiveStatus}     on_tape

Get Object Response
    [Arguments]         ${Md5}
    &{secret_key}=  GetSecret    mediahaven.viaa@viaa.${environment.short_name}
    Set auth header   viaa@viaa  ${secret_key.passwd}
    Log        ${Md5}
    ${resp}=       REST.Get    mediahaven-rest-api/resources/media/?q=%2B(Md5:${Md5})&startIndex=0&nrOfResults=1
    Log    ${resp}
    Object      response body
    Integer     response status   200
    [return]  ${resp}

Group has permission on object
    #Group is a UUID code such as cc7c56fc-58c8-4650-bc63-7e695fbc506c, Permissiontype is a type such as Export
    [arguments]      ${Md5}     ${Group}      ${Permissiontype}
    ${resp}=       Get Object Response        ${Md5}
    @{Permissions}=             Create List         ${resp["body"]["MediaDataList"][0]["RightsManagement"]["Permissions"][${Permissiontype}]}    
    List Should Contain Value        @{Permissions}        ${Group}

Object has license
    #License is eg. VIAA-ONDERWIJS
    [arguments]      ${Md5}     ${License}
    ${resp}=       Get Object Response        ${Md5}
    @{Licenses}=             Create List         ${resp["body"]["MediaDataList"][0]["Dynamic"]["dc_rights_licenses"]["multiselect"]}   
    List Should Contain Value        @{Licenses}        ${License}