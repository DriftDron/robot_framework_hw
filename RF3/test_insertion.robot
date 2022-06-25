*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Test Timeout    2s
Metadata        Автор   Андрей Кан
Resource        resource.robot
*** Test Cases ***
Check PATCH Request
    [Documentation]    Проверка изменения поля categoryname в таблице bootcamp.categories
    [Tags]    change
    Cat.Change Category Names In Categories    alias=alias    new_name=test1
    ${res_postgrest}    Cat.Get Categories From Rest    alias=alias
    ${res_db}           Cat.Get Categories From Db
    Col.Lists Should Be Equal    ${res_db}    ${res_postgrest}