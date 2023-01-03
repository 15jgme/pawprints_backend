#!/bin/bash

docker build -t pawprints-backend --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) . 