FROM centos:7

RUN yum -y install java-11-openjdk wget unzip bc && yum -y clean all
RUN wget --quiet "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip"
RUN cd /opt && unzip /sonarqube-8.4.2.36762.zip && mv sonarqube-8.4.2.36762 sonarqube && rm -rf /sonarqube-8.4.2.36762.zip

COPY /src/scripts/entrypoint.sh /opt/sonarqube/entrypoint.sh

RUN useradd -u 1001 -r -g 0 -d /opt/sonarqube -s /sbin/nologin \
    -c "Default Application User" default && \
    chown -R 1001:0 ${APP_ROOT}

WORKDIR /opt/sonarqube

EXPOSE 9000

USER 1001

ENTRYPOINT ["/bin/sh", "/opt/sonarqube/entrypoint.sh"]
