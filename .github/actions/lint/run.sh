#!/bin/bash
set -e

./dep_install.sh
ament_${LINTER} src/
