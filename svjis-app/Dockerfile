FROM maven:3.6-jdk-8-alpine AS builder

RUN apk update && apk upgrade && apk add --no-cache bash git openssh 
WORKDIR /app
RUN git clone https://github.com/svjis/svjis.git svjis
WORKDIR /app/svjis
RUN git checkout master
RUN mvn -e -B  package


FROM tomcat:9-jdk8-openjdk-slim

ENV DB_SERVER=localhost \
    DB_USERNAME=admin \
    DB_PASSWORD=password
WORKDIR /usr/local/tomcat/webapps/
COPY setenv.sh /usr/local/tomcat/bin/setenv.sh
RUN chmod ugo+x /usr/local/tomcat/bin/setenv.sh
COPY --from=builder /app/svjis/target/*.war /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["catalina.sh", "run"]
