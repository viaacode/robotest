*** Settings ***
Documentation    Test #023\n
...              Tests to asses the stability of MediaHaven's OAI-PMH API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1106083876/Test+023+-+Testing+van+de+OAI-PMH+API
Library          RequestsLibrary
Library          XML     use_lxml=True
Resource         ../http.resource
Suite setup      Create RequestsSession with headers   oai_pmh   https://${mediahaven.oai_pmh.url}/mediahaven-oai/oai/ 

*** Test Cases ***
Test Identify
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=Identify
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test ListMetadataFormats
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=ListMetadataFormats
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test ListSets
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=ListSets
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test ListIdentifiers
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=ListIdentifiers&metadataPrefix=mets
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test GetRecord oai_dc by noid
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=GetRecord&metadataPrefix=oai_dc&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test GetRecord mets by noid
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=GetRecord&metadataPrefix=mets&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test GetRecord mhs by noid
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=GetRecord&metadataPrefix=mhs&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test GetRecord mets-mhs by noid
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=GetRecord&metadataPrefix=mets-mhs&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH

Test GetRecord oai_dc by umid
    [Tags]            oai_pmh  mediahaven  prd  qas  int
    ${resp}=          Get Request   oai_pmh   ?verb=GetRecord&metadataPrefix=oai_dc&identifier=umid:${mediahaven.oai_pmh.data.umid}
    Status Should Be  200           ${resp}
    Log               ${resp.content}
    ${root}=          Parse XML     ${resp.content}
    Should Be Equal   ${root.tag}   OAI-PMH
