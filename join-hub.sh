#!/bin/bash
HUB=${SELENIUM_HUB_ADDRESS:-hub:4444}
until /usr/bin/phantomjs --webdriver `hostname -I | awk '{print $1}'`:8080 ${PHANTOMJS_OPTS} --webdriver-selenium-grid-hub http://${HUB}
do
  echo "Trying to connect to ${HUB}"
  sleep 3
done
