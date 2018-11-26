FROM jenkins/jenkins:latest
#ENV DOCKERVERSION=18.06.1-ce
#RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
#  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
#                 -C /usr/local/bin docker/docker \
#  && rm docker-${DOCKERVERSION}.tgz

# Distributed Builds plugins
COPY docker /usr/local/bin/
COPY kubectl /usr/local/bin/
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack
RUN /usr/local/bin/install-plugins.sh ldap
RUN /usr/local/bin/install-plugins.sh gitee
RUN /usr/local/bin/install-plugins.sh github
RUN /usr/local/bin/install-plugins.sh ldapemail
RUN /usr/local/bin/install-plugins.sh kubernetes-cd



# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes

# install Maven
USER root
RUN apt-get update && apt-get install -y maven git
RUN /usr/local/bin/install-plugins.sh workflow-aggregator
RUN /usr/local/bin/install-plugins.sh workflow-job
USER jenkins
ENV TZ=Asia/Shanghai
