FROM oraclelinux:7-slim

# Install dependencies
RUN yum -y install \
    java-1.8.0-openjdk \
    tar \
    unzip \
    && yum clean all

# Add WebLogic installer and configurations
COPY wls-12.2.1.4.0.jar /tmp/wls.jar

# Set environment variables
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0

# Install WebLogic
RUN mkdir /opt/weblogic \
    && java -jar /tmp/wls.jar -mode=silent -silent_xml=/tmp/wls_silent.xml \
    && rm /tmp/wls.jar

# Expose WebLogic ports
EXPOSE 7001 9001

# Start WebLogic Server
CMD ["/opt/weblogic/wlserver/server/bin/startWebLogic.sh"]