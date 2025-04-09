#!/bin/bash

# Install hey (HTTP load generator)
go install github.com/rakyll/hey@latest
export PATH=$PATH:$(go env GOPATH)/bin

# Generate load for foo.localhost
echo "Testing foo.localhost..."
hey -n 1000 -c 50 -host foo.localhost http://localhost:80 > foo_results.txt

# Generate load for bar.localhost
echo "Testing bar.localhost..."
hey -n 1000 -c 50 -host bar.localhost http://localhost:80 > bar_results.txt

# Combine results
cat foo_results.txt bar_results.txt