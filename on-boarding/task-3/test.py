import unittest
from unittest import mock
from identify_broken_links import get_broken_urls


TEST_URL = "http://testurl.com/"
DUMMY_HTML = """
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="">
</head>

<body>
    <a href="#">Alive</a>
    <a href="/">Alive</a>
    <a href="/lvl_2">Alive</a>
    <a href="?hi">Alive</a>
    <a href="/nonexistant">Non existant</a>    
</body>

</html>
"""


class MockResponse():
    def __init__(self, text_data="", status_code=200):
        self.status_code = status_code
        self.text_data = text_data

    @property
    def text(self):
        return self.text_data


def mocked_requests_get(*args, **kwargs):
    url = args[0]

    if url == TEST_URL + "nonexistant":
        return MockResponse(status_code=404)
    else:
        return MockResponse(DUMMY_HTML, 200)


class TestGetBrokenLink(unittest.TestCase):
    @mock.patch('requests.get', side_effect=mocked_requests_get)
    def test_get_broken_link(self, mock_get):        
        output = get_broken_urls(TEST_URL)
        expected = ['http://testurl.com/nonexistant']
        
        self.assertCountEqual(expected, output)


if __name__ == "__main__":
    unittest.main()
