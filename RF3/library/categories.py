from robot.libraries.BuiltIn import BuiltIn
from JsonValidator import JsonValidator

class Categories:
    builtin_lib = BuiltIn()
    js = JsonValidator()

    def get_requests_lib(self):
        return self.builtin_lib.get_library_instance("Req")

    def get_postgresql_lib(self):
        return self.builtin_lib.get_library_instance("DB")

    def change_category_names_in_categories(self, alias, new_name, expected_status='204'):
        data = {"categoryname": new_name}
        result = self.get_requests_lib().patch_on_session(alias=alias, url='categories',
                                                          data=data, expected_status=expected_status)
        self.get_requests_lib().status_should_be(expected_status=expected_status, response=result)

    def get_categories_from_rest(self, alias='alias'):
        result = self.get_requests_lib().get_on_session(alias=alias, url='categories')
        return result.json()

    def get_categories_from_db(self):
        sql = "SELECT * FROM bootcamp.categories"
        return self.get_postgresql_lib().execute_sql_string_mapped(sql)

