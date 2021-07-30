*** Settings ***
Documentation    Test #023\n
...              Tests to asses the stability of MediaHaven's OAI-PMH API.\n
...              See: https://meemoo.atlassian.net/wiki/spaces/SI/pages/1106083876/Test+023+-+Testing+van+de+OAI-PMH+API
Library          RequestsLibrary
Library          XML     use_lxml=True
Resource         ../http.resource
Suite setup      Create RequestsSession with headers   oai_pmh   https://${mediahaven.oai_pmh.url}/mediahaven-oai/oai/ 

*** Test Cases ***
1.5.1 Test Identify
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh     ?verb=Identify
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    Element Should Exist    ${root}         Identify

1.5.1 Test ListMetadataFormats
    [Tags]              oai_pmh  mediahaven  prd  qas  int
    ${resp}=            Get Request     oai_pmh     ?verb=ListMetadataFormats
    Status Should Be    200             ${resp}
    Log                 ${resp.content}
    ${root}=            Parse XML       ${resp.content}
    Should Be Equal     ${root.tag}     OAI-PMH
    ${lmf}=             Get Element     ${root}     ListMetadataFormats
    ${formats}=         Get Elements    ${lmf}      metadataFormat
    Length Should Be    ${formats}      6

1.5.1 Test ListSets
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh     ?verb=ListSets
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    Element Should Exist    ${root}         ListSets/set

1.5.1 Test ListRecords mets
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh     ?verb=ListRecords&metadataPrefix=mets
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    Element Should Exist    ${root}         ListRecords/record

2.1 Test ListRecords oai_dc
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh     ?verb=ListRecords&metadataPrefix=oai_dc
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    Element Should Exist    ${root}         ListRecords/record

1.5.1 Test ListIdentifiers
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh     ?verb=ListIdentifiers&metadataPrefix=mets
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    Element Should Exist    ${root}         ListIdentifiers/header

1.5.1 Test GetRecord oai_dc by noid
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh                                 ?verb=GetRecord&metadataPrefix=oai_dc&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    ${record}=              Get Element     ${root}                                 GetRecord/record
    Element Text Should Be  ${record}       noid:${mediahaven.oai_pmh.data.noid}    header/identifier
    Element Text Should Be  ${record}       ${mediahaven.oai_pmh.data.noid}         metadata/dc/identifier

1.5.1 Test GetRecord mets by noid
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh                                 ?verb=GetRecord&metadataPrefix=mets&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    ${record}=              Get Element     ${root}                                 GetRecord/record
    Element Text Should Be  ${record}       noid:${mediahaven.oai_pmh.data.noid}    header/identifier
    Element Should Exist    ${record}       metadata/mets

1.5.1 Test GetRecord mhs by noid
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh                                 ?verb=GetRecord&metadataPrefix=mhs&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    ${record}=              Get Element     ${root}                                 GetRecord/record
    Element Text Should Be  ${record}       noid:${mediahaven.oai_pmh.data.noid}    header/identifier
    Element Should Exist    ${record}       metadata/Sidecar

1.5.1 Test GetRecord mets-mhs by noid
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request   oai_pmh                                   ?verb=GetRecord&metadataPrefix=mets-mhs&identifier=noid:${mediahaven.oai_pmh.data.noid}
    Status Should Be        200           ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML     ${resp.content}
    Should Be Equal         ${root.tag}   OAI-PMH
    ${record}=              Get Element     ${root}                                 GetRecord/record
    Element Text Should Be  ${record}       noid:${mediahaven.oai_pmh.data.noid}    header/identifier
    Element Should Exist    ${record}       metadata/mets

1.5.1 Test GetRecord oai_dc by umid
    [Tags]                  oai_pmh  mediahaven  prd  qas  int
    ${resp}=                Get Request     oai_pmh                                 ?verb=GetRecord&metadataPrefix=oai_dc&identifier=umid:${mediahaven.oai_pmh.data.umid}
    Status Should Be        200             ${resp}
    Log                     ${resp.content}
    ${root}=                Parse XML       ${resp.content}
    Should Be Equal         ${root.tag}     OAI-PMH
    ${record}=              Get Element     ${root}                                 GetRecord/record
    Element Text Should Be  ${record}       umid:${mediahaven.oai_pmh.data.umid}    header/identifier
    Element Should Exist    ${record}       metadata/dc

1.5.1 Test UnknownVerb
    [Tags]                          oai_pmh  mediahaven  prd  qas  int
    ${resp}=                        Get Request     oai_pmh     ?verb=UnknownVerb
    Status Should Be                200             ${resp}
    Log                             ${resp.content}
    ${root}=                        Parse XML       ${resp.content}
    Should Be Equal                 ${root.tag}     OAI-PMH
    ${error}=                       Get Element     ${root}     error
    Element Attribute Should Be     ${error}        code        badVerb
