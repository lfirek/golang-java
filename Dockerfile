FROM golang:1.7.3
RUN apt-get update && apt-get install -y --no-install-recommends \
	bzip2 \
	unzip \
	xz-utils \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

RUN { \
	echo '#!/bin/sh'; \
	echo 'set -e'; \
	echo; \
	echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

ENV JAVA_VERSION 7u111
ENV JAVA_DEBIAN_VERSION 7u111-2.6.7-2~deb8u1

RUN set -x \
    && apt-get update \
    && apt-get install -y \
	openjdk-7-jre-headless="$JAVA_DEBIAN_VERSION" \
    && rm -rf /var/lib/apt/lists/* \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]