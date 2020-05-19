# Pull the base image with given version.
ARG BUILD_TERRAFORM_VERSION="0.12.20"
FROM mcr.microsoft.com/terraform-test:${BUILD_TERRAFORM_VERSION}

ARG MODULE_NAME="module-template"


# Set work directory.
RUN mkdir /go
RUN mkdir /go/bin
RUN mkdir /go/src
RUN mkdir /go/src/${MODULE_NAME}
COPY . /go/src/${MODULE_NAME}
WORKDIR /go/src/${MODULE_NAME}

# Install dep.
ENV GOPATH /go
ENV PATH /usr/local/go/bin:$GOPATH/bin:$PATH
RUN /bin/bash -c "curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh"

RUN ["bundle", "install", "--gemfile", "./Gemfile"]
