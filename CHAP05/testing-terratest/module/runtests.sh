#!/bin/bash
echo "==> dep ensure"
dep ensure
echo "==> go test"
go test -v ./tests/ -timeout 30m