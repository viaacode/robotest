*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST     https://${mediahaven.rest.url}
Library       Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Library        FtpLibrary
Resource      ../http.resource
Resource      ../ingest.resource

*** Test Cases ***

#Clear files if they are in archive

1.4.1 Delete audio files
    [Tags]        ftp  mediahaven  qas  audio
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.audio}
    FOR    ${Md5}     IN      @{Md5s}
        Mediahaven delete    ${Md5}
    END

1.4.1 Delete video files
    [Tags]        ftp  mediahaven  qas  video
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.video}
    FOR    ${Md5}     IN      @{Md5s}
        Mediahaven delete    ${Md5}
    END

1.4.1 Delete image files
    [Tags]        ftp  mediahaven  qas  image
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.image}
    FOR    ${Md5}     IN      @{Md5s}
        Mediahaven delete    ${Md5}
    END

#Upload all on RTV

1.4.1 Upload audio files
    [Tags]        ftp  mediahaven  qas   audio
    @{files}        Create List       @{mediahaven.ingest.mediafiles.audio}
    FOR    ${file}    IN    @{files}
            Essence only upload     tests/mediahaven/ingest/media/${file}  /rtv/aa111fe7-51d6-41db-bf44-b085a4464c22/bulkuploadrtv/${file}
    END

1.4.1 Upload video files
    [Tags]        ftp  mediahaven  qas   video
    @{files}        Create List       @{mediahaven.ingest.mediafiles.video}
    FOR    ${file}    IN    @{files}
            Essence only upload     tests/mediahaven/ingest/media/${file}  /rtv/aa111fe7-51d6-41db-bf44-b085a4464c22/bulkuploadrtv/${file}
    END

1.4.1 Upload image files
    [Tags]        ftp  mediahaven  qas   image
    @{files}        Create List       @{mediahaven.ingest.mediafiles.image}
    FOR    ${file}    IN    @{files}
            Essence only upload     tests/mediahaven/ingest/media/${file}  /rtv/aa111fe7-51d6-41db-bf44-b085a4464c22/bulkuploadrtv/${file}
    END