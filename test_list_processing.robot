*** Settings ***
Documentation           First task\n\n
...                     Using the following list: @{MYLIST} test finding min, max, unique and sum
*** Variables ***
@{MYLIST}               ${1}  ${2}  ${3}  ${5}  ${1}  ${0}  ${-1}  ${10}
*** Test Cases ***
Find min and max in list
    [Documentation]     Find min and max values in MYLIST
    [Tags]              max  min
    ${mylist_min} =     Evaluate    min(@{MYLIST})
    ${mylist_max} =     Evaluate    max(@{MYLIST})
    Log                 Max value = ${mylist_max} Min value = ${mylist_min}

Find unique values in list
    [Documentation]      Find unique values in MYLIST
    [Tags]               unique
    ${mylist_unique} =   Evaluate  list(set(@{MYLIST}))
    Log                  uniqe values in list = ${mylist_unique}

Find sum of all elements in list
    [Documentation]     Sum of all elements in MYLIST
    [Tags]              sum
    ${mylist_sum} =     Evaluate  sum(@{MYLIST})
    Log                 sum of all elements in list = ${mylist_sum}
