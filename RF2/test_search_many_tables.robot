*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Metadata        Автор   Андрей Кан
Resource        resource.robot

*** Variables ***
${SQL}      SELECT age, firstname, title
...         FROM bootcamp.customers
...         JOIN bootcamp.cust_hist USING(customerid)
...         JOIN bootcamp.products USING(prod_id)
...         WHERE age<%(age)s AND title LIKE %(title)s
${POSTGREST_PARAMS}    age=lt.21&select=age,firstname,products!inner(title)&products.title=like.%FISH%
&{DB_PARAMS}           age=21      title=%FISH%

*** Test Cases ***
Check search from mulptiple tables
    [Documentation]     Проверка поиска данных из нескольких таблиц
    ${firstname}    Get Firstname From PostRest     ${POSTGREST_PARAMS}
    @{result}       Get Firstname From DB           &{DB_PARAMS}
    Compare Result    ${result}    ${firstname}

*** Keywords ***
Get Firstname From PostRest
    [Arguments]     ${filter}
    ${resp} =       Req.Get On Session    alias   customers    params=${filter}
    ${firstname}    Js.Get Elements       ${resp.json()}     $..firstname
    [Return]        ${firstname}

Get Firstname From DB
    [Arguments]     &{dict_params}
    ${params}       Create Dictionary     &{dict_params}
    @{result}       DB.Execute Sql String Mapped    ${SQL}    &{params}
    [Return]        ${result}

Compare Result
    [Arguments]     ${res_from_db}    ${firstnames}
    ${firstnames_db}    Create List
    FOR  ${i}   IN  @{res_from_db}
        Col.Append To List    ${firstnames_db}    ${i}[firstname]
    END
    Lists Should Be Equal    ${firstnames_db}    ${firstnames}    ignore_order=True


