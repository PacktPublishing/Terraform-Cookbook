GOLANG_VERSION="1.14.6"
GOLANG_OS_ARCH=linux-amd64

mkdir "$HOME/go"
mkdir "$HOME/go/bin"
mkdir "$HOME/go/src"

curl -Os https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_OS_ARCH}.tar.gz >/dev/null 2>&1 &&
  tar -zxvf go${GOLANG_VERSION}.${GOLANG_OS_ARCH}.tar.gz -C /usr/local/ >/dev/null

# Refresh Go environment.
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"

