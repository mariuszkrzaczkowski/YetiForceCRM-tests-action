#!/bin/bash

echo "$INPUT_PHP"

pwd

ls -all "$GITHUB_WORKSPACE"

echo "HOME: $HOME"
echo "GITHUB_RUN_ID: $GITHUB_RUN_ID"
echo "GITHUB_SERVER_URL: $GITHUB_SERVER_URL"
echo "GITHUB_API_URL: $GITHUB_API_URL"
echo "GITHUB_GRAPHQL_URL: $GITHUB_GRAPHQL_URL"
echo "GITHUB_ACTION : $GITHUB_ACTION"
echo "GITHUB_EVENT_PATH : $GITHUB_EVENT_PATH "
echo "GITHUB_ACTION_REPOSITORY : $GITHUB_ACTION_REPOSITORY "
echo "GITHUB_PATH : $GITHUB_PATH "
echo "GITHUB_ENV : $GITHUB_ENV "
echo "RUNNER_TOOL_CACHE : $RUNNER_TOOL_CACHE "
echo "RUNNER_TEMP : $RUNNER_TEMP "
echo "RUNNER_WORKSPACE : $RUNNER_WORKSPACE "
echo "ACTIONS_RUNTIME_URL : $ACTIONS_RUNTIME_URL "
echo "ACTIONS_RUNTIME_TOKEN : $ACTIONS_RUNTIME_TOKEN "
echo "ACTIONS_CACHE_URL : $ACTIONS_CACHE_URL "
