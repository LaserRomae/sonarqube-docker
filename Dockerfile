FROM centos:7

RUN yum -y install java-11-openjdk wget unzip bc && yum -y clean all
RUN wget --quiet "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip"
RUN cd /opt && unzip /sonarqube-8.4.2.36762.zip && mv sonarqube-8.4.2.36762 sonarqube && rm -rf /sonarqube-8.4.2.36762.zip

COPY /src/scripts/entrypoint.sh /opt/sonarqube/entrypoint.sh

RUN useradd -r sonar

RUN chown -R sonar /opt/sonarqube
RUN chgrp -R 0 /opt/sonarqube
RUN chmod -R g+rw /opt/sonarqube
RUN find /opt/sonarqube -type d -exec chmod g+x {} +

WORKDIR /opt/sonarqube

EXPOSE 9000

USER sonar

ENTRYPOINT ["/bin/sh", "/opt/sonarqube/entrypoint.sh"]
