*** Settings ***
Library    RequestsLibrary          WITH NAME    Req
Library    PostgreSQLDB             WITH NAME    DB
Library    JsonValidator            WITH NAME    Js
Library    Collections              WITH NAME    Col
Library    customers.Customers      WITH NAME    Cust
Library    categories.Categories    WITH NAME    Cat
*** Keywords ***
Test Setup
    Req.Create session             alias    http://localhost:3000
    DB.Connect To Postgresql       hadb     ha      password2021dljfklkla1!kljf;
...                                localhost    8432
Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql