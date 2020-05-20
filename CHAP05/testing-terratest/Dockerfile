FROM mikaelkrief/go-terraform:0.12.25

ARG ARG_MODULE_NAME="module-test"
ENV MODULE_NAME=${ARG_MODULE_NAME}

# Set work directory.
RUN mkdir /go/src/${MODULE_NAME}
COPY ./module /go/src/${MODULE_NAME}
WORKDIR /go/src/${MODULE_NAME}

RUN chmod +x runtests.sh
ENTRYPOINT [ "./runtests.sh" ]
