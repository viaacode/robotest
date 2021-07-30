*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST     https://archief-media.viaa.be
Library       Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Library          FtpLibrary
Resource      ../http.resource
Resource      ../ingest.resource

*** Test Cases ***

1.5.2 Check permissions on audio files
    [Tags]        mediahaven  qas  audio sidecar
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.sidecar}
    FOR    ${Md5}     IN      @{Md5s}    
        Wait until keyword succeeds    10x    20s     Check If Exists    ${Md5}
        Wait until keyword succeeds    10x   1s     Check If On Tape   ${Md5}
        Group has permission on object     ${Md5}      cc7c56fc-58c8-4650-bc63-7e695fbc506c       Export
            END