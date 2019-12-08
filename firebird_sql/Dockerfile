FROM debian:10

ARG DB_PW
ARG COMPANY_NAME

# Setup Proxy
# -----------
#RUN export http_proxy="http://my.proxy.com:8080/"
#RUN export https_proxy="http://my.proxy.com:8080/"
#RUN export ftp_proxy="http://my.proxy.com:8080/"
#RUN echo 'Acquire::http::Proxy "http://my.proxy.com:8080/";' > /etc/apt/apt.conf.d/proxy.conf
#RUN echo 'Acquire::https::Proxy "http://my.proxy.com:8080/";' >> /etc/apt/apt.conf.d/proxy.conf

# Install Firebird DB
# -------------------
RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install curl
RUN apt-get -y install firebird3.0-server

WORKDIR /opt

# Create Database
# ---------------
RUN mkdir /opt/db
RUN echo "SVJIS_PRODUCTION = /opt/db/SVJIS_PRODUCTION.FDB" >> /etc/firebird/3.0/databases.conf
COPY create_db.sql create_db.sql 
RUN isql-fb -i create_db.sql
RUN rm create_db.sql

# Update Admin
# ------------
COPY update_admin.sql update_admin.sql
RUN sed -i "s/CHANGE_IT/$DB_PW/g" update_admin.sql
RUN isql-fb -i update_admin.sql security.db
RUN rm update_admin.sql

# Create Company
# --------------
RUN curl -k -s https://raw.githubusercontent.com/svjis/svjis/master/db_schema/database.sql -O
RUN isql-fb -i database.sql db/SVJIS_PRODUCTION.FDB
RUN rm database.sql
COPY create_company.sql create_company.sql
RUN sed -i "s/COMPANY_NAME/$COMPANY_NAME/g" create_company.sql
RUN isql-fb -i create_company.sql db/SVJIS_PRODUCTION.FDB
RUN rm create_company.sql

# Or restore DB from backup file
# ------------------------------
#COPY db_backup.fbk db_backup.fbk
#RUN gbak -rep -v db_backup.fbk db/SVJIS_PRODUCTION.FDB
#RUN rm db_backup.fbk

# Modify Database Setup
# ---------------------
RUN echo "AuthServer = Legacy_Auth, Srp, Win_Sspi" >> /etc/firebird/3.0/firebird.conf
RUN echo "AuthClient = Legacy_Auth, Srp, Win_Sspi" >> /etc/firebird/3.0/firebird.conf
RUN echo "UserManager = Legacy_UserManager, Srp" >> /etc/firebird/3.0/firebird.conf
RUN echo "WireCrypt = enabled" >> /etc/firebird/3.0/firebird.conf
RUN sed -i "s/RemoteBindAddress = localhost/#RemoteBindAddress = localhost/g" /etc/firebird/3.0/firebird.conf

# Run Firebird
# ------------
RUN chown firebird db/SVJIS_PRODUCTION.FDB
RUN chgrp firebird db/SVJIS_PRODUCTION.FDB

EXPOSE 3050/tcp
ENTRYPOINT ["/usr/sbin/fbguard"]
