#!/bin/bash

echo "$INPUT_PHP"

echo "GITHUB_WORKSPACE: $GITHUB_WORKSPACE"
ls -all "$GITHUB_WORKSPACE"

pwd

cat /github/workspace/README.md

printenv
