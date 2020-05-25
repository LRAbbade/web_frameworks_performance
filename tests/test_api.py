from unittest import TestCase

import requests


class TestApi(TestCase):
    
    def test_hello_world(self):
        r = requests.get('http://localhost/')
        self.assertEqual(r.status_code, 200, msg='root didn\'t return 200')
        self.assertIn('Hello World', r.text, msg='server response is wrong')
