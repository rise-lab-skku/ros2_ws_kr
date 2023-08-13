#!/bin/bash
set -e

./dep_install.sh
./build.sh
./test.sh
