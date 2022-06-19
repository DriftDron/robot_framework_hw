*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Metadata        Автор   Андрей Кан
Resource        resource.robot
*** Variables ***
${SQL}    SELECT * FROM bootcamp.categories
*** Test Cases ***
Check PATCH Request
    [Documentation]    Проверка изменения поля categoryname в таблице bootcamp.categories
    Change Category Names In Categories   test
    ${res_postgrest}    Get Categories From PostgRest
    ${res_db}           Execute Sql String Mapped    ${SQL}
    Should Be Equal As Strings    ${res_db}    ${res_postgrest}

*** Keywords ***
Change Category Names In Categories
    [Arguments]    ${new_name}
    &{data}    Create Dictionary       categoryname=${new_name}
    ${resp}    Req.PATCH On Session    alias    categories   ${data}
    Status Should Be    204    ${resp}

Get Categories From PostgRest
    ${resp} =    Req.Get On Session     alias   categories
    ${res_postgrest}    Set Variable    ${resp.json()}
    [Return]    ${res_postgrest}