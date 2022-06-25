*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Test Timeout    1s
Metadata        Автор   Андрей Кан
Resource        resource.robot
*** Variables ***
${POSTGREST_PARAMS}    age=lt.21&select=age,firstname,products!inner(title)&products.title=like.%FISH%
&{DB_PARAMS}           age=21      title=%FISH%
*** Test Cases ***
Check search from mulptiple tables
    [Documentation]     Проверка поиска данных из нескольких таблиц
    [Tags]    search
    ${firstname_rest}    Cust.Get Firstnames From Rest    alias=alias    params=${POSTGREST_PARAMS}
    ${firstname_db}      Get Firstnames From Db     ${DB_PARAMS}
    Col.Lists Should Be Equal    ${firstname_db}    ${firstname_rest}    ignore_order=True
