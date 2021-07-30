*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST     https://${mediahaven.rest.url}
Library       Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Library        FtpLibrary
Resource      ../../http.resource
Resource      ../ingest.resource

*** Test Cases ***

#Delete and upload with sidecar

1.4.2 Delete Sidecar-uploaded files
    [Tags]        ftp  mediahaven  qas  sidecar
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.sidecar}
    FOR    ${Md5}     IN      @{Md5s}
        Mediahaven delete    ${Md5}
    END

1.4.2 Upload files with sidecar for permissions and licenses test
    [Tags]        ftp  mediahaven  qas   image tape sidecar
    @{files}        Create List       @{mediahaven.ingest.mediafiles.image}
    FOR    ${file}    IN    @{files}
            Sidecar upload    tests/mediahaven/ingest/media/${file}  /rtv/TAPE-SHARE-EVENTS/${file}
    END