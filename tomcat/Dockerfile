FROM maven:3.6-jdk-8-alpine AS builder

RUN apk update && apk upgrade && apk add --no-cache bash git openssh 
WORKDIR /app
RUN git clone https://github.com/svjis/svjis.git svjis
WORKDIR /app/svjis
RUN git checkout develop
RUN mvn -e -B  package


FROM ubuntu:18.04

ARG DB_SR
ARG DB_US
ARG DB_PW
ARG DOMAIN

# Setup Proxy
# -----------
#RUN export http_proxy="http://my.proxy.com:8080/"
#RUN export https_proxy="http://my.proxy.com:8080/"
#RUN export ftp_proxy="http://my.proxy.com:8080/"
#RUN echo 'Acquire::http::Proxy "http://my.proxy.com:8080/";' > /etc/apt/apt.conf.d/proxy.conf
#RUN echo 'Acquire::https::Proxy "http://my.proxy.com:8080/";' >> /etc/apt/apt.conf.d/proxy.conf

# Install Tomcat
# --------------
RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install tomcat8

WORKDIR /app

# Install SVJIS
# -------------
RUN rm -Rf /var/lib/tomcat8/webapps/*
COPY --from=builder /app/svjis/target/*.war /var/lib/tomcat8/webapps/ROOT.war 
                                                                              
# Setup Tomcat
# --------------------------
RUN echo "db.server=$DB_SR" >> /etc/tomcat8/catalina.properties
RUN echo "db.user=$DB_US" >> /etc/tomcat8/catalina.properties
RUN echo "db.password=$DB_PW" >> /etc/tomcat8/catalina.properties 

# Create certificate
# ------------------
#RUN keytool -genkey -keyalg RSA -noprompt -alias tomcat -dname "CN=$DOMAIN, OU=NA, O=NA, L=NA, S=NA, C=NA" -keystore keystore.jks -validity 9999 -storepass changeme -keypass changeme

COPY entry.sh /app/entry.sh

EXPOSE 8080/tcp
ENTRYPOINT ["/app/entry.sh"]
 