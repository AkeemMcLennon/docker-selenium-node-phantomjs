/usr/bin/phantomjs --webdriver `hostname -I | awk '{print $1}'`:8080 --webdriver-selenium-grid-hub http://hub:4444
