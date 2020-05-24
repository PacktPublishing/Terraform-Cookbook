#!/bin/bash
set -e

# Check if OS is supported.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  TERRAFORM_OS_ARCH=linux_amd64
  GOLANG_OS_ARCH=linux-amd64
elif [[ "$OSTYPE" == "darwin"* ]]; then
  TERRAFORM_OS_ARCH=darwin_amd64
  GOLANG_OS_ARCH=darwin-amd64
else
  echo "Unsupported Operating System: $OSTYPE" 1>&2
  exit 1
fi

# Version, OS and Arch for Terraform.
TERRAFORM_VERSION="0.12.20"
# Version for Ruby SDK.
RUBY_VERSION="2.3.3"
RUBY_INSTALLED_VERSION_REGEX="^(ruby) ([0-9].[0-9].[0-9]p[0-9]+)"
RBENV_INSTALLED_VERSION_REGEX="^(rbenv) ([0-9].[0-9].[0-9])"
# Versions for gem packages.
GEM_BUNDLER_VERSION="1.16.0"
GEM_COLORIZE_VERSION="0.8.1"
GEM_KITCHEN_TERRAFORM_VERSION="3.0.0"
GEM_TEST_KITCHEN_VERSION="1.16.0"
GEM_RAKE_VERSION="12.3.0"
GEM_RSPEC_VERSION="3.7.0"
# Version for Golang.
GOLANG_VERSION="1.10.3"

# Install rbenv & ruby-build.
if type rbenv &> /dev/null; then
  echo "rbenv was previously installed."
else
  # Clean up legacy .rbenv
  if [[ -d "$HOME/.rbenv" ]]; then
    echo "Clean up legacy ~/.rbenv."
    rm -rf "$HOME/.rbenv"
  fi

  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # rbenv.
    apt-get update && \
    apt-get install autoconf bison build-essential libssl-dev libyaml-dev \
            libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 \
            libgdbm-dev unzip
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    export PATH="$HOME/.rbenv/bin:$PATH"
    # ruby-build.
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  else # darwin*
    # rbenv & ruby-build.
    brew update && \
    brew install rbenv ruby-build
  fi
fi

# Initialize rbenv.
eval "$(rbenv init -)"

# Install Ruby SDK.
# TODO: skip unneccessary install.
rbenv install ${RUBY_VERSION} && rbenv global ${RUBY_VERSION}

# Install Terraform runtime.
curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${TERRAFORM_OS_ARCH}.zip && \
  curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
  curl -s https://keybase.io/hashicorp/pgp_keys.asc | gpg --import && \
  curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig && \
  gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
  shasum -a 256 -c terraform_${TERRAFORM_VERSION}_SHA256SUMS 2>&1 | grep "${TERRAFORM_VERSION}_${TERRAFORM_OS_ARCH}.zip:\sOK" && \
  unzip -o terraform_${TERRAFORM_VERSION}_${TERRAFORM_OS_ARCH}.zip -d /usr/local/bin
# Cleanup downloaded files.
rm terraform_${TERRAFORM_VERSION}_${TERRAFORM_OS_ARCH}.zip
rm terraform_${TERRAFORM_VERSION}_SHA256SUMS
rm terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig

# Install Go SDK.
curl -Os https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_OS_ARCH}.tar.gz >/dev/null 2>&1 && \
  tar -zxvf go${GOLANG_VERSION}.${GOLANG_OS_ARCH}.tar.gz -C /usr/local/ >/dev/null

# Install Gem packages.
gem update --system && \
  gem install bundler --no-document --version=${GEM_BUNDLER_VERSION} --user-install && \
  gem install colorize --no-document --version=${GEM_COLORIZE} --user-install && \
  gem install rake --no-document --version=${GEM_RAKE_VERSION} --user-install && \
  gem install rspec --no-document --version=${GEM_RSPEC_VERSION} --user-install

# Refresh Go environment.
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"

# Install Go dep.
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
