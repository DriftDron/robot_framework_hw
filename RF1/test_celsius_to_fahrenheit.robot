*** Settings ***
Documentation           Second task\n\n
...                     Check the following formula tF = 9/5 * tC + 32
Library     Collections     WITH NAME    Col

*** Test Cases ***
Test formula with test data
    [Documentation]     Check the following formula tF = 9/5 * tC + 32
    [Tags]              Celsius Fahrenheit
    &{test_data}    Create Dictionary    0=${32}   350=${662}
...                                      -32=${-25.6}      100=${212}
    #get keys from test_data and substitute in tF = 9/5 * tC + 32
    @{temp_in_cels} =   Col.Get Dictionary Keys     ${test_data}
    #create empty dict in order to store values calculated by formula
    &{formula_res} =    Create Dictionary
    FOR     ${key}      IN     @{temp_in_cels}
        ${value} =      Celsius To Fahrenheit    ${key}
        Col.Set To Dictionary   ${formula_res}      ${key}      ${value}
    END
    Col.Dictionaries Should Be Equal    ${formula_res}      ${test_data}

*** Keywords ***
Celsius To Fahrenheit
    [Arguments]     ${temperature_celsius}
    ${temperature_fahrenheit} =    Evaluate    9 / 5 * ${temperature_celsius} + 32
    [Return]    ${temperature_fahrenheit}