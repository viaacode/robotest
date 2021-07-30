*** Settings ***
Documentation    Test #022\n
...              Tests to asses the stability of MediaHaven's REST-ish API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1105887278/Test+022+-+Testing+van+de+REST+API
Library       REST     https://${mediahaven.rest.url}
Library       Vault/Vault.py  %{VAULT_ADDR}  %{GITHUB_TOKEN}  False
Library          FtpLibrary
Resource      ../http.resource
Resource      ../ingest.resource

*** Test Cases ***

1.5.1 Check browse and peak files for audio
    [Tags]        mediahaven  qas  audio
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.audio}
    FOR    ${Md5}     IN      @{Md5s}    
        Wait until keyword succeeds    10x    20s     Check If Exists    ${Md5}
        Wait until keyword succeeds    10x   1s     Check If On Tape   ${Md5}
        Get Object Response        ${Md5}
        #browse mp3:
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}    ${mediahaven.rest.url}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToKeyframe"]}    .jpg
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToVideo"]}    browse.mp3
        String     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["Container"]}
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["FileSize"]} > 0
        #browse m4a:
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][2]["Label"]}    m4a
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][2]["PathToVideo"]}    browse.m4a
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][2]["FileSize"]} > 0
        #browse mp4:
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][3]["Label"]}    mp4
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][3]["PathToVideo"]}    browse.mp4
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][3]["FileSize"]} > 0
        #peak file:
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][1]["HasKeyFrames"]}    false
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][1]["PathToVideo"]}    peak-0.json
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][1]["FileSize"]} > 0
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}    ${mediahaven.rest.url}
        ${MediaObjectId}=      ${resp["body"]["MediaDataList"][0]["Internal"]["MediaObjectId"]}
        Log        ${MediaObjectId}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}    ${MediaObjectId}
        Should Be True 	    len('${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}') > 90 	
    END

1.5.1 Check browse and peak files for video
    [Tags]        mediahaven  qas  video
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.video}
    FOR    ${Md5}     IN      @{Md5s}    
        Wait until keyword succeeds    6x    10s     Check If Exists    ${Md5}
        Wait until keyword succeeds    10x   1s     Check If On Tape   ${Md5}
        Get Object Response        ${Md5}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}    ${mediahaven.rest.url}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToKeyframe"]}    .jpg
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToVideo"]}    browse.
        String     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["Container"]}
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["FileSize"]} > 0
    END

1.5.1 Check browse and peak files for image
    [Tags]        mediahaven  qas  image
    @{Md5s}        Create List       @{mediahaven.ingest.mediamd5.image}
    FOR    ${Md5}     IN      @{Md5s}    
        Wait until keyword succeeds    6x    10s     Check If Exists    ${Md5}
        Wait until keyword succeeds    10x   1s     Check If On Tape   ${Md5}
        Get Object Response        ${Md5}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["BaseUrl"]}    ${mediahaven.rest.url}
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToKeyframe"]}    .jpg
        Should Contain     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["PathToVideo"]}    browse.
        String     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["Container"]}
        Should Be True     ${resp["body"]["MediaDataList"][0]["Internal"]["Browses"]["Browse"][0]["FileSize"]} > 0
    END