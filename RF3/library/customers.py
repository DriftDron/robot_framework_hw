from robot.libraries.BuiltIn import BuiltIn
from JsonValidator import JsonValidator

class Customers:
    builtin_lib = BuiltIn()
    js = JsonValidator()

    def get_requests_lib(self):
        return self.builtin_lib.get_library_instance("Req")

    def get_postgres_lib(self):
        return self.builtin_lib.get_library_instance("DB")

    def get_data_from_rest(self, alias, params, expected_status='200'):
        resp = self.get_requests_lib().get_on_session(alias=alias, url='/customers?',
                                                      params=params, expected_status=expected_status)
        return resp.json()

    def get_firstnames_from_rest(self, alias, params):
        result = self.get_data_from_rest(alias=alias, params=params)
        firstnames = self.js.get_elements(result, '$..firstname')
        return firstnames

    def get_data_from_db(self, params):
        sql = """SELECT age, firstname, title
                 FROM bootcamp.customers
                 JOIN bootcamp.cust_hist USING(customerid)
                 JOIN bootcamp.products USING(prod_id)
                 WHERE age<%(age)s AND title LIKE %(title)s"""
        result = self.get_postgres_lib().execute_sql_string_mapped(sql, **params)
        return result

    def get_firstnames_from_db(self, params):
        data_from_db = self.get_data_from_db(params)
        firstnames_db = []
        for i in data_from_db:
            firstnames_db.append(i['firstname'])
        return firstnames_db
