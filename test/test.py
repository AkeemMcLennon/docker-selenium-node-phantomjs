from selenium.webdriver.remote.webdriver import WebDriver
from time import sleep
import py.test


SELENIUM_HOST = "selenium"
SELENIUM_PORT = "4444"


def test_get_url():
    sleep(10)
    TEST_URL = "http://httpbin/html"
    driver = WebDriver("http://%s:%s/wd/hub" % (SELENIUM_HOST, SELENIUM_PORT),
        desired_capabilities={"browserName": "phantomjs"})
    driver.get(TEST_URL)
    elem = driver.find_element_by_tag_name("h1")
    assert "Moby-Dick" in elem.text
