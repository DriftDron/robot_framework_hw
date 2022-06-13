*** Settings ***
Documentation           First task\n\n
...                     Using the following list: @{MYLIST} test finding min, max, unique and sum
Library     Collections    WITH NAME    Col

*** Variables ***
@{MYLIST}                   ${1}  ${2}  ${3}  ${5}  ${1}  ${0}  ${-1}  ${10}
@{MYLIST_UNIQUE_CHECK}      ${1}  ${2}  ${3}  ${5}  ${0}  ${-1}  ${10}

*** Test Cases ***
Find unique values in list
    [Documentation]         Check that unique values in MYLIST are being found correctly
    [Tags]                  unique
    ${mylist_unique} =      Col.Remove duplicates      ${MYLIST}
    Col.Lists Should Be Equal       ${mylist_unique}    ${MYLIST_UNIQUE_CHECK}

Test min value is -1 and max values is 10
    [Documentation]     Check that min and max values in MYLIST are being found correctly
    [Tags]              max  min
    Create Sorted List
    Should Be Equal As Numbers      ${mylist_sorted}[0]     -1
    Should Be Equal As Numbers      ${mylist_sorted}[-1]     10

Test sum of all elements in MYLIST is 21
    [Documentation]     Check that sum of all elements in MYLIST is being found correctly
    [Tags]              sum
    ${sum}              Set Variable    ${0}
    FOR     ${i}    IN      @{MYLIST}
        ${sum} =    Evaluate    ${sum} + ${i}
    END
    Should Be Equal As Numbers      ${sum}      21

*** Keywords ***
Create sorted list
    Set Test Variable   ${mylist_sorted}    ${MYLIST}
    Col.Sort list       ${mylist_sorted}
