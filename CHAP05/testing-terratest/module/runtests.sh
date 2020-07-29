#!/bin/bash
echo "==> Get terratest package"
go get github.com/gruntwork-io/terratest/modules/terraform
echo "==> go test"
go test -v ./tests/ -timeout 30m