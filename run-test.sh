#!/bin/bash
docker-compose start
sleep 2
docker-compose run --rm tester
