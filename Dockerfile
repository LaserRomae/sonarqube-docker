FROM centos:7

RUN yum -y install java-11-openjdk wget unzip bc
RUN wget --quiet "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip"
RUN cd /opt && unzip /sonarqube-8.4.2.36762.zip && mv sonarqube-8.4.2.36762 sonarqube
RUN groupadd sonar && useradd -M -g sonar -d /opt/sonarqube sonar
RUN chown -R sonar:sonar /opt/sonarqube && rm -rf /sonarqube-8.4.2.36762.zip

COPY --chown=sonar:sonar /src/scripts/entrypoint.sh /entrypoint.sh

USER sonar
WORKDIR /opt/sonarqube

EXPOSE 9000

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
