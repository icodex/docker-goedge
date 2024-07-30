FROM alpine:latest
LABEL maintainer="icodex@msn.com"
ENV TZ="Asia/Shanghai"
ENV ROOT_DIR=/usr/local/goedge

ARG RUN_TYPE
ENV RUN_TYPE=${RUN_TYPE}

ARG VERSION
ENV VERSION=${VERSION}

COPY build /build/

RUN /build/base.sh \
    && /build/install.sh ${RUN_TYPE}

WORKDIR /usr/local/goedge
ENTRYPOINT [ "/usr/local/goedge/run.sh" ]
