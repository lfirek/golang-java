FROM golang:1.16.0-buster
RUN apt-get update && apt-get install -y --no-install-recommends \
	bzip2 \
	unzip \
	xz-utils \
	software-properties-common \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

RUN { \
	echo '#!/bin/sh'; \
	echo 'set -e'; \
	echo; \
	echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home


ENV JAVA_HOME /usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/jre

RUN set -x \
    && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update \
    &&  apt-get install -y adoptopenjdk-8-hotspot
