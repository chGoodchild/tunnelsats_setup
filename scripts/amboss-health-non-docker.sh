#!/bin/bash

URL="https://api.amboss.space/graphql"
NOW=$(date -u +%Y-%m-%dT%H:%M:%S%z)
SIGNATURE=$(/usr/local/bin/lncli signmessage "$NOW" | jq -r .signature)

/usr/bin/cgexec -g net_cls:splitted_processes curl -s -X POST -H "Content-Type: application/json" -d '{
  "query": "mutation healthCheck($signature: String!, $timestamp: String!) { healthCheck(signature: $signature, timestamp: $timestamp) }",
  "variables": {
   "signature": "'"$SIGNATURE"'",
    "timestamp": "'"$NOW"'"
  }
}' $URL --output /dev/null