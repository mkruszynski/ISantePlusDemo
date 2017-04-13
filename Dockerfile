FROM google/debian:wheezy

ADD openmrs-runtime.properties /var/lib/tomcat7/openmrs-runtime.properties
ADD run.sh /root/run.sh
ADD openmrs_dump.sql /root/openmrs_dump.sql

COPY openmrs-2.5-modules /openmrs-modules

RUN apt-get update; \
  apt-get install -y curl openjdk-7-jre tomcat7; \
  curl -L http://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.0.4.1/openmrs.war/download \
       -o /var/lib/tomcat7/webapps/openmrs.war; \
  mkdir /var/lib/OpenMRS; \
  mkdir /usr/share/tomcat7/.OpenMRS; \
  mkdir /usr/share/tomcat7/.OpenMRS/modules; \
  mv -v /openmrs-modules/* /usr/share/tomcat7/.OpenMRS/modules/; \
  apt-get install -y mysql-server; \
  chown tomcat7:tomcat7 /var/lib/tomcat7/openmrs-runtime.properties /var/lib/OpenMRS /usr/share/tomcat7/.OpenMRS; \
  chmod +x /root/run.sh

EXPOSE 8080

CMD ["/root/run.sh"]
