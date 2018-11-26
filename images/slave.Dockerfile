FROM jenkins/jnlp-slave:alpine
ENV PATH=/usr/local/lib/maven:$PATH
RUN rm -rf /var/cache/apk/*
#ENV DOCKERVERSION=18.06.1-ce
#RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
#  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
#                 -C /usr/local/bin docker/docker \
#  && rm docker-${DOCKERVERSION}.tgz

# Distributed Builds plugins
COPY docker /usr/local/bin/
COPY kubectl /usr/local/bin/

# install Maven
USER root
RUN apk update && apk upgrade && \
    apk add --no-cache git
RUN wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz && \
    tar xzf apache-maven-3.6.0-bin.tar.gz && \
    mv apache-maven-3.6.0 /usr/local/lib/maven && \
    rm -fr apache-ma*.gz
RUN apk add --no-cache go
RUN apk --no-cache add ca-certificates wget
RUN wget --quiet --output-document=/etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-java-openjfx/releases/download/8.151.12-r0/java-openjfx-8.151.12-r0.apk && \
   apk add --no-cache java-openjfx-8.151.12-r0.apk && rm -rf /var/cache/apk/* *.apk
ENV PATH=/usr/local/lib/maven/bin:$PATH
USER jenkins
ENV PATH=/usr/local/lib/maven/bin:$PATH
