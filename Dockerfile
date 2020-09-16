FROM centos:7

RUN yum -y install java-11-openjdk wget unzip bc && yum -y clean all
RUN wget --quiet "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip"
RUN cd /opt && unzip /sonarqube-8.4.2.36762.zip && mv sonarqube-8.4.2.36762 sonarqube && rm -rf /sonarqube-8.4.2.36762.zip

COPY /src/scripts/entrypoint.sh /opt/sonarqube/entrypoint.sh

RUN chgrp -R 0 /opt/sonarqube && chmod -R g=u /opt/sonarqube

WORKDIR /opt/sonarqube

EXPOSE 9000

USER 10001

ENTRYPOINT ["/bin/sh", "/opt/sonarqube/entrypoint.sh"]
