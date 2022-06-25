*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Test Timeout    2s
Metadata        Автор   Андрей Кан
Resource        resource.robot
*** Test Cases ***
Check search from mulptiple tables
    [Documentation]     Проверка поиска данных из нескольких таблиц: customers, products
    [Tags]    search
    ${firstname_rest}    Cust.Get Firstnames From Rest
    ${firstname_db}      Cust.Get Firstnames From Db
    Col.Lists Should Be Equal    ${firstname_db}    ${firstname_rest}    ignore_order=True
