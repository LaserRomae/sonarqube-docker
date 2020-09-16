#!/bin/sh

echo "UID: $UID"
cat /etc/passwd | grep $UID

find /opt/sonarqube -ls

# changing the amount of RAM to be used for Java to 75% of available mem
memory=$( echo "($( free -m | grep '^Mem:' | tr -s ' ' | cut -d ' ' -f 2 ) / 1024 * 0.75 * 1024)/1; scale=0" | bc )
echo "setting RAM to ${memory} mb"

echo "starting sonarqube"
sudo su -l sonar -c "cd /opt/sonarqube; java -Xms${memory}m -Xmx${memory}m -jar lib/sonar-application-8.4.2.36762.jar -Djava.security.egd=file:/dev/./urandom"
